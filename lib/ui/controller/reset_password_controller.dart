import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordLoader = false;

  bool get resetPasswordLoader => _resetPasswordLoader;

  String get message => _message;
  String _message = '';
  bool isSuccess = false;

  Future<bool> resetPassword(String email, String otp, String password) async {
    _resetPasswordLoader = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.recoverPassword,
        body: {"email": email, "OTP": otp, "password": password});

    _resetPasswordLoader = false;
    update();
    if (response.isSuccess) {
      _message = 'Password Successfully Changed';
      isSuccess = true;
    } else {
      _message = 'Failed Occurred ';
    }
    return isSuccess;
  }
}
