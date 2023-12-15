import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/ui/widgets/profile_app_bar.dart';
import '../../Style/style.dart';
import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controller/auth_controller.dart';
import '../widgets/bodyBackground.dart';
import '../widgets/smack_message.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();

  bool _updateProfileInProgress = false ;
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = authController.user?.email ?? '';
    _firstNameTEController.text = authController.user?.firstName ?? '';
    _lastNameTEController.text = authController.user?.lastName ?? '';
    _mobileTEController.text = authController.user?.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileAppBar(
            enableOnTap: false,
          ),
          Expanded(
            child: bodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Update Profile',
                            style: headlineForm(colorDarkBlue),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          PhotoPicker(),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailTEController,
                            validator: (value)
                            {
                              isEmailValid(value);
                            },
                            decoration: const InputDecoration(labelText: 'Email'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _firstNameTEController,
                            validator: (value)
                            {
                              return isValidate(value , 'First Name');
                            },
                            decoration:
                                const InputDecoration(labelText: 'First Name'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _lastNameTEController,
                            validator: (value) {
                              return isValidate(value, 'Last Name');
                            },
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _mobileTEController,
                            validator: (value) {
                              return isPhoneNumberValid(value);
                            },
                            decoration:
                                const InputDecoration(labelText: 'Mobile'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordTEController,
                            // validator: (value)
                            // {
                            //   return isValidate(value, 'Password');
                            // },
                            decoration:
                                const InputDecoration(labelText: 'Password (not required)'),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: _updateProfileInProgress == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate())
                                    {
                                      return updateProfile() ;
                                    }
                                },
                                style: formButtonStyle(),
                                child: const Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

   PhotoPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: colorWhite, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: colorLightGray,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )),
                child: Text('Photos', style: profileAppHeading(colorWhite)),
              )),
          Expanded(
              flex: 3,
              child:  InkWell(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.camera, imageQuality: 50);
                  if (image != null) {
                    photo = image;
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Visibility(
                    visible: photo == null,
                    replacement: Text(photo?.name ?? ''),
                    child: const Text('Select a photo'),
                  ),
                ),
              ),),
        ],
      ),
    );
  }
  Future<void> updateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "email": _emailTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }
    // picture
    if (photo != null){
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      Get.find<AuthController>().updateUserInformation(UserModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          photo: photoInBase64 ?? authController.user?.photo

      ));
      if (mounted) {
        showSnackMessage(context, 'Profile Successfully Updated!');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Update profile failed. Try again.',true);
      }
    }
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
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
