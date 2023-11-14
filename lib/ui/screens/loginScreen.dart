import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/forgotPasswordScreen.dart';
import 'package:task_manager_app/ui/screens/registrationScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';
import 'main_bottom_nav_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
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
                'Get Started With',
                style: headlineForm(colorDarkBlue),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainBottomNavScreen()));
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                  ),
                  style: formButtonStyle(),
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
                            builder: (context) => forgotPasswordScreen()));
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
    )));
  }
}
