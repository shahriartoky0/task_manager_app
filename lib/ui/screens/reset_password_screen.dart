import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/forgotPasswordScreen.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.values});

  final Map<String, dynamic> values;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool resetPasswordLoader = false ;

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
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Set Password',
                  style: headlineForm(colorDarkBlue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Minimum length of must be 8 characters with letters and number combination',
                  style: forgotPassword(colorLightGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  validator: (value) {
                    return isValidate(value, 'Password');
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  validator: (value) {
                    return isValidate(value, 'Password');
                  },
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    replacement: const Center(child: CircularProgressIndicator(),),
                    visible: resetPasswordLoader == false ,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordTEController.text !=
                              _confirmPasswordTEController.text) {
                            if (mounted) {
                              showSnackMessage(context, 'Passwords do not match', true);
                            }
                            return;

                          }
                          resetPasswordLoader = true ;
                          if (mounted)
                            {
                              setState(() {});
                            }
                          final NetworkResponse response = await NetworkCaller()
                              .postRequest(Urls.recoverPassword, body: {
                            "email": widget.values['email'],
                            "OTP": widget.values['otp'],
                            "password": _passwordTEController.text
                          });

                          resetPasswordLoader = false  ;
                          if (mounted)
                          {
                            setState(() {});
                          }
                          if (response.isSuccess) {
                            if (mounted) {
                              showSnackMessage(
                                  context, 'Password Successfully Changed');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const loginScreen()),
                                  (route) => false);
                            }
                          }
                        }
                      },
                      style: formButtonStyle(),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account ?",
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

  String? isValidate(String? value, String field) {
    if (value?.trim().isEmpty ?? true) {
      return "Please Enter $field";
    }
    return null;
  }
}
