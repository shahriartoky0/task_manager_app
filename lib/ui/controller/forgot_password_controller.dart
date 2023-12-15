import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../screens/pin_verification_screen.dart';

class ForgotPasswordController extends GetxController {
  bool get forgotPasswordLoader => _forgotPasswordLoader;
  bool _forgotPasswordLoader = false;

  Future<bool> forgotPassword(String email) async {
    _forgotPasswordLoader = true;
    update();
    bool isSuccess = false ;

    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.verifyEmail(email),
    );
    _forgotPasswordLoader = false;
    update();
    if (response.isSuccess) {
      Get.to(pin_verification_screen(email: email));
      isSuccess = true ;
    }
    return isSuccess ;
  }
}
