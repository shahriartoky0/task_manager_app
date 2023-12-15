import 'package:get/get.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class CompletedTasksController extends GetxController
{
  TaskListModel taskListModel = TaskListModel();
  bool _completedTaskLoader = false ;
  bool get completedTaskLoader  => _completedTaskLoader ;
  bool isSuccess = false ;
  Future<bool> getCompletedTaskList() async {
    _completedTaskLoader = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTaskList);
   _completedTaskLoader = false;
    update();
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
      isSuccess = true ;
    }
    update();
    return isSuccess ;
  }
}