import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/screens/reset_password_screen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';

class pin_verification_screen extends StatefulWidget {
  const pin_verification_screen({super.key});

  @override
  State<pin_verification_screen> createState() =>
      _pin_verification_screenState();
}

class _pin_verification_screenState extends State<pin_verification_screen> {
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
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        'Pin Verification',
                        style: headlineForm(colorDarkBlue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Provide the 6 digit verification pin which was sent to your email address',
                        style: forgotPassword(colorLightGray),
                      ),
                      SizedBox(
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
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Icon(Icons.arrow_circle_right_outlined),
                          style: formButtonStyle(),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen()));
                          },
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
                                      builder: (context) => loginScreen()));
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
