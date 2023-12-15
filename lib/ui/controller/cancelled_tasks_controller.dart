import 'package:get/get.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class CancelTasksController extends GetxController
{
  TaskListModel taskListModel = TaskListModel();
  bool _cancelledTaskLoader = false ;
  bool get cancelledTaskLoader => _cancelledTaskLoader;
  bool isSuccess = false ;
  Future<bool> getCancelledTaskList() async {
    _cancelledTaskLoader = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelledTaskList);
    _cancelledTaskLoader = false;
   update();
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
      isSuccess = true ;
    }
    return isSuccess ;
  }
}