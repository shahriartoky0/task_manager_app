import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/screens/loginScreen.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../../Style/style.dart';
import '../controller/registration_controller.dart';
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
  final RegistrationController _registrationController =
      Get.find<RegistrationController>();

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
                  'Join With Us',
                  style: headlineForm(colorDarkBlue),
                ),
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                    width: double.infinity,
                    child:GetBuilder<RegistrationController>(
                      builder: (registrationController) {
                        return Visibility(
                          visible: registrationController.signUpInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: _signup,
                            style: formButtonStyle(),
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    )),
                const SizedBox(
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
                        Get.offAll(const loginScreen());
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
      final response = await _registrationController.signup(
          _emailTEController.text.trim(),
          _firstNameTEController.text.trim(),
          _lastNameTEController.text.trim(),
          _mobileNameTEController.text.trim(),
          _passwordNameTEController.text.trim());

      if (response) {
        clearTextFields();

        if (mounted) {
          showSnackMessage(context, _registrationController.message);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, _registrationController.message, true);
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
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileNameTEController.dispose();
    _passwordNameTEController.dispose();
    super.dispose();
  }
}
