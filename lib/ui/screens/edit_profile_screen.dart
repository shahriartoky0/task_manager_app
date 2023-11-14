import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_app_bar.dart';

import '../../Style/style.dart';
import '../widgets/bodyBackground.dart';
import 'loginScreen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileAppBar(enableOnTap: false,),
          Expanded(
            child: bodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Update Profile',
                          style: headlineForm(colorDarkBlue),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        PhotoPicker(),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Mobile'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(Icons.arrow_circle_right_outlined),
                            style: formButtonStyle(),
                          ),
                        ),
                      ],
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

  Container PhotoPicker() {
    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: colorLightGray,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    )),
                                child: Text('Photos',
                                    style: profileAppHeading(colorWhite)),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('Empty'),
                              )),
                        ],
                      ),
                    );
  }
}
