import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';
import '../../data/utility/urls.dart';
import '../widgets/smack_message.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({super.key});

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNameTEController = TextEditingController();
  final TextEditingController _passwordNameTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

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
                  'Join With Us',
                  style: headlineForm(colorDarkBlue),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailTEController,
                  validator: (value) {
                    return isEmailValid(value);
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  validator: (value) {
                    return isValidate(value, 'First Name');
                  },
                  decoration: const InputDecoration(labelText: 'First Name'),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  validator: (value) {
                    return isValidate(value, 'Last Name');
                  },
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileNameTEController,
                  validator: (value) {
                    return isPhoneNumberValid(value);
                  },
                  decoration: const InputDecoration(labelText: 'Mobile'),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordNameTEController,
                  obscureText: true,
                  validator: (value) {
                    return isValidate(value, 'Password');
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _signUpInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: _signup,
                        child: Icon(Icons.arrow_circle_right_outlined),
                        style: formButtonStyle(),
                      ),
                    )),
                SizedBox(
                  height: 60,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account ?",
                      style: formBottom(colorDarkBlue),
                    ),
                    InkWell(
                      child: Text(
                        ' Sign In',
                        style: signUp(colorGreen),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const loginScreen()),
                            (route) => false);
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

  //Sign up request function
  Future<void> _signup() async {
    if (_formKey!.currentState!.validate()) {
      _signUpInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registrationUrl, body: {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _emailTEController.text,
        "password": _passwordNameTEController.text.trim(),
      });
      _signUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        clearTextFields();

        if (mounted) {
          showSnackMessage(
              context, 'Account Has been Created! Please Sign In ');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Account Creation Failed !!', true);
        }
      }
    }
  }

  // Clearing the text Fields
  void clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileNameTEController.clear();
    _passwordNameTEController.clear();
  }

  // validator function
  String? isValidate(String? value, String field) {
    if (value?.trim().isEmpty ?? true) {
      return "Please Enter $field";
    }
    return null;
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

// validate Phone Number
  String? isPhoneNumberValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'Please enter a valid 11-digit phone number';
    }
    return null;
  }

  @override
  void dispose() {
    _emailTEController.dispose(); // TODO: implement dispose
    _firstNameTEController.dispose(); // TODO: implement dispose
    _lastNameTEController.dispose(); // TODO: implement dispose
    _mobileNameTEController.dispose(); // TODO: implement dispose
    _passwordNameTEController.dispose(); // TODO: implement dispose
    super.dispose();
  }
}
