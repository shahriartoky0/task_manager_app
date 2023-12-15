import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/reset_password_controller.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';

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
  final ResetPasswordController _resetPasswordController =
      Get.find<ResetPasswordController>();
  bool resetPasswordLoader = false;

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
                  child: GetBuilder<ResetPasswordController>(
                      builder: (resetPasswordController) {
                    return Visibility(
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      visible:
                          resetPasswordController.resetPasswordLoader == false,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_passwordTEController.text !=
                                _confirmPasswordTEController.text) {
                              if (mounted) {
                                showSnackMessage(
                                    context, 'Passwords do not match', true);
                              }
                              return;
                            }
                            String email = widget.values['email'];
                            String otp = widget.values['otp'];
                            final response =
                                await _resetPasswordController.resetPassword(
                                    email, otp, _passwordTEController.text);

                            if (response) {
                              if (mounted) {
                                showSnackMessage(
                                    context, _resetPasswordController.message);
                                Get.offAll(const loginScreen());
                              }
                            } else {
                              if (mounted) {
                                showSnackMessage(context,
                                    _resetPasswordController.message, true);
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
                    );
                  }),
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
                        Get.to(const loginScreen());
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
