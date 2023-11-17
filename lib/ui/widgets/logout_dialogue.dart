import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';

import '../../Style/style.dart';
import '../controller/auth_controller.dart';
import '../screens/loginScreen.dart';

class LogoutDialogue extends StatelessWidget {
  const LogoutDialogue({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alert',
        style: TextStyle(color: colorRed),
      ),
      content: Text(
        'Are you sure you want to Logout ?',
        style: profileAppHeading(colorDarkBlue),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              AuthController.clearAuthData();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const loginScreen()),
                  (route) => false,
                );

                showSnackMessage(
                    context, 'Successfully Logged Out. Sign in to continue');
              }
            },
            child: Text(
              'Yes',
              style: formBottom(colorBlue),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: formBottom(colorGreen),
            )),
      ],
    );
  }
}
