import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/screens/reset_password_screen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';
import '../controller/forgot_password_controller.dart';
import '../controller/pin_verification_controller.dart';

class pin_verification_screen extends StatefulWidget {
  pin_verification_screen({super.key, required this.email});

  final String email;

  @override
  State<pin_verification_screen> createState() =>
      _pin_verification_screenState();
}

class _pin_verification_screenState extends State<pin_verification_screen> {
  final ForgotPasswordController _forgotPasswordController =
      Get.find<ForgotPasswordController>();

  String enteredPin = '';
  bool otpLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                'Pin Verification',
                style: headlineForm(colorDarkBlue),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Provide the 6 digit verification pin which was sent to your email address',
                style: forgotPassword(colorLightGray),
              ),
              const SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: colorWhite,
                  //input Background
                  activeColor: colorGreen,
                  // after giving input color
                  selectedFillColor: colorWhite,
                  inactiveFillColor: colorWhite,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: (value) {
                  enteredPin = value;
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                  return Visibility(
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    visible: pinVerificationController.otpLoader == false,
                    child: ElevatedButton(
                      style: formButtonStyle(),
                      onPressed: () async {
                        final response = await pinVerificationController
                            .pinVerification(widget.email, enteredPin);

                        if (response) {
                          if (mounted) {
                            Get.to(ResetPasswordScreen(
                              values: {
                                'email': widget.email,
                                'otp': enteredPin
                              },
                            ));
                          }
                        } else {
                          if (mounted) {
                            showSnackMessage(context,
                                pinVerificationController.failedMessage, true);
                          }
                        }
                      },
                      child: const Text(
                        'Verify',
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
                    "Have account?",
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
    )));
  }
}
