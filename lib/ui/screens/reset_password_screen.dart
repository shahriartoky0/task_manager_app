import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/forgotPasswordScreen.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                'Set Password',
                style: headlineForm(colorDarkBlue),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Minimum length of must be 8 characters with letters and number combination',
                style: forgotPassword(colorLightGray),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirm Password'),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: formButtonStyle(),
                  child:  Text('Confirm',style: TextStyle(fontSize: 16),),
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
                              builder: (context) =>
                                  const loginScreen()));
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
