import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/screens/pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool forgotPasswordLoader = false ;

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
                  'Your Email Address',
                  style: headlineForm(colorDarkBlue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: forgotPassword(colorLightGray),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailTEController,
                  validator: (value) {
                    return isEmailValid(value);
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    replacement: const Center(child: CircularProgressIndicator(),),
                    visible: forgotPasswordLoader == false,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          forgotPasswordLoader = true ;
                          if(mounted)
                            {
                              setState(() {});
                            }

                          final NetworkResponse response =
                              await NetworkCaller().getRequest(
                            Urls.verifyEmail(_emailTEController.text.trim()),
                          );
                          forgotPasswordLoader = false ;
                          if(mounted)
                          {
                            setState(() {});
                          }
                          if (response.isSuccess) {
                            print('jojo');
                            if (mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          pin_verification_screen(
                                            email: _emailTEController.text.trim(),
                                          )));
                            }
                          } else {
                            print(_emailTEController.text.trim());
                            print(response.statusCode);

                          }
                        }
                      },
                      child: Icon(Icons.arrow_circle_right_outlined),
                      style: formButtonStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have account?",
                      style: formBottom(colorDarkBlue),
                    ),
                    InkWell(
                      child: Text(
                        ' Sign In',
                        style: signUp(colorGreen),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const loginScreen()));
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
}
