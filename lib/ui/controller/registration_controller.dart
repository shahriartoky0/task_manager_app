import 'package:get/get.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class RegistrationController extends GetxController {
  bool _signUpInProgress = false;

  String _message = '';

  String get message => _message;

  bool get signUpInProgress => _signUpInProgress;
  bool isSuccess = false;

  Future<bool> signup(String email, String firstName, String lastName,
      String mobile, String password) async {
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registrationUrl, body: {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      _message = 'Account Has been Created! Please Sign In';
      isSuccess = true;
    } else {
      _message = 'Account Creation Failed !!';
    }
    return isSuccess;
  }
}
