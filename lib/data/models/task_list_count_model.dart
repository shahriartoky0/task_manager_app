import 'package:task_manager_app/data/models/task_list_count.dart';

class TaskListCountModel {
  String? status;
  List<TaskCount>? taskListCountList;

  TaskListCountModel({this.status, this.taskListCountList});

  TaskListCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskListCountList = <TaskCount>[];
      json['data'].forEach((v) {
        taskListCountList!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskListCountList != null) {
      data['data'] = taskListCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


