class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registrationUrl = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String taskCount = '$_baseUrl/taskStatusCount';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String inProgressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static const String recoverPassword = '$_baseUrl/RecoverResetPass';


  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String verifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

 static String verifyOTP(String email ,String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';




}