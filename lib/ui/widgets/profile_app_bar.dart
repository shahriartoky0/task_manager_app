import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/edit_profile_screen.dart';

import '../../Style/style.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.account_circle_sharp),
      ),
      title: Text(
        'Rabbil Hasan',
        style: profileAppHeading(colorWhite),
      ),
      subtitle: Text(
        'rabbil@gmail.com',
        style: profileAppSubtitle(colorWhite),
      ),
      tileColor: colorGreen,
      trailing: enableOnTap
          ? const Icon(
              Icons.arrow_forward,
              color: colorWhite,
            )
          : null,
      onTap: () {
        if (enableOnTap) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()));
        }
      },
    );
  }
}
