import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';
import '../../Style/style.dart';
import 'logout_dialogue.dart';

class ProfileAppBar extends StatefulWidget {
  const ProfileAppBar({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {


  // @override
  // void initState() {
  //   AuthController.user ; // problem needs to be issued
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    String base64String= AuthController.user?.photo ?? '';
    if (base64String.startsWith('data:image'))
      {
        base64String = base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      }
  Uint8List imageBytes = const Base64Decoder().convert(base64String);

    return ListTile(
      leading: CircleAvatar(
        child: AuthController.user?.photo == null
            ? const Icon(Icons.person)
            : ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        "${AuthController.user?.firstName ?? 'Name not Found'} ${AuthController.user?.lastName ?? ''}",
        style: profileAppHeading(colorWhite),
      ),
      subtitle: Text(
        AuthController.user?.email ?? 'Email not Found',
        style: profileAppSubtitle(colorWhite),
      ),
      tileColor: colorGreen,
      trailing: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return LogoutDialogue(mounted: mounted);
              });
        },
        color: colorWhite,
        iconSize: 35,
        icon: const Icon(Icons.logout_rounded),
      ),
      onTap: () {
        if (widget.enableOnTap) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
    );
  }
}
