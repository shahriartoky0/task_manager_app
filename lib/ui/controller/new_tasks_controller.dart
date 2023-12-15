import 'package:get/get.dart';
import '../../data/models/task_list_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class NewTaskController extends GetxController {
  bool isSuccess = false ;
  bool _newTaskLoad = false;
  bool _taskCountLoad = false;
  bool get getNewTaskInProgress => _newTaskLoad;
  bool get getNewTaskCountInProgress => _taskCountLoad;

  TaskListModel get taskListModel => _taskListModel;
  TaskListCountModel get taskListCountModel => _taskListCountModel;

  TaskListModel _taskListModel = TaskListModel();
  TaskListCountModel _taskListCountModel = TaskListCountModel();

  Future<bool> getNewTaskList() async {
    _newTaskLoad = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTaskList);
    _newTaskLoad = false;

    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse!);
      isSuccess = true ;
    }
    update();
    return isSuccess ;
  }
  //----------------------------
  Future<void> getTaskListCount() async {
    _taskCountLoad = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskCount);
    _taskCountLoad = false;
   update();
    if (response.isSuccess) {
      _taskListCountModel = TaskListCountModel.fromJson(response.jsonResponse!);
    }
    _taskCountLoad = false;
    update();
  }
}
