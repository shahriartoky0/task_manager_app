import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/controller/cancelled_tasks_controller.dart';
import 'package:task_manager_app/ui/controller/completed_tasks_controller.dart';
import 'package:task_manager_app/ui/controller/forgot_password_controller.dart';
import 'package:task_manager_app/ui/controller/in_progress_tasks_controller.dart';
import 'package:task_manager_app/ui/controller/login_controller.dart';
import 'package:task_manager_app/ui/controller/new_tasks_controller.dart';
import 'package:task_manager_app/ui/controller/pin_verification_controller.dart';
import 'package:task_manager_app/ui/controller/registration_controller.dart';
import 'package:task_manager_app/ui/controller/reset_password_controller.dart';
import 'package:task_manager_app/ui/screens/splashScreen.dart';

import 'Style/style.dart';

class TaskManagerApp extends StatelessWidget {

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey ,
      home: splashScreen(),

      theme: ThemeData(
        inputDecorationTheme:const InputDecorationTheme(
          fillColor: colorWhite,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        primarySwatch: Colors.green,
        primaryColor: Colors.green,

      ),
      initialBinding: ControllerBinder(),
    );
  }
}
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(InProgressTasksController());
    Get.put(CompletedTasksController());
    Get.put(CancelTasksController());
    Get.put(RegistrationController());
    Get.put(AuthController());
    Get.put(ForgotPasswordController());
    Get.put(PinVerificationController());
    Get.put(ResetPasswordController());


  }

}