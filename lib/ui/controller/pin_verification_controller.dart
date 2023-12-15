import 'package:get/get.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';


class PinVerificationController extends GetxController {
  bool _otpLoader = false;
  String _failedMessage = '';

  String get failedMessage => _failedMessage;

  bool get otpLoader => _otpLoader;

  Future<bool> pinVerification(String email, String pin) async {
    bool isSuccess = false;
    _otpLoader = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.verifyOTP(email, pin),
    );
    _otpLoader = false;
    update();

    if (response.jsonResponse!['status'] == 'success') {

      isSuccess = true;
    } else {
      _failedMessage = 'Invalid OTP';
    }
    return isSuccess;
  }
}
