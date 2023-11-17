import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/ui/screens/forgotPasswordScreen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';
import '../../data/utility/urls.dart';
import 'main_bottom_nav_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool signInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Get Started With',
                  style: headlineForm(colorDarkBlue),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailTEController,
                    validator: (value) {
                      return isEmailValid(value);
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordTEController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Please Enter Your Password !";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: signInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _signIn,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                      style: formButtonStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: InkWell(
                    child: Text(
                      'Forgot Password ?',
                      style: forgotPassword(colorLightGray),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const forgotPasswordScreen()));
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: formBottom(colorDarkBlue),
                    ),
                    InkWell(
                      child: Text(
                        ' Sign Up',
                        style: signUp(colorGreen),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const registrationScreen()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    )));
  }

  // API Request Handle
  Future<void> _signIn() async {
    signInProgress = true;
    if (mounted) {
      setState(() {});
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, body: {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text.trim()
    });
    signInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      clearTextFields();
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', response.jsonResponse!['token']);

      if (mounted) {
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainBottomNavScreen()));
        }
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Incorrect Username or Password!', true);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Login Failed! Please Try again', true);
        }
      }
    }
  }

  // validate Email Address
  String? isEmailValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // clearing textField function
  void clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
