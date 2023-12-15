import 'package:get/get.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class InProgressTasksController extends GetxController {
  TaskListModel taskListModel = TaskListModel();
  bool get inProgressTaskLoader => _inProgressTaskLoader;
  bool _inProgressTaskLoader = false;
  bool isSuccess = false ;

  Future<bool> getInProgressTaskList() async {
    _inProgressTaskLoader = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTaskList);
    _inProgressTaskLoader = false;
    update();
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
      isSuccess = true ;
    }
    update();
    return isSuccess ;
  }
}
