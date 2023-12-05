import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';

import '../../data/models/task_list_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  TaskListCountModel taskListCountModel = TaskListCountModel();
  bool cancelledTaskLoader = false;

  Future<void> getCancelledTaskList() async {
    cancelledTaskLoader = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTaskList);
    cancelledTaskLoader = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
  }

  @override
  void initState() {
    getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ProfileAppBar(),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: bodyBackground(
            child: Visibility(
              visible: cancelledTaskLoader == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  getCancelledTaskList();
                },
                child: ListView.separated(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) => TaskItemCard(
                    task: taskListModel.taskList![index],
                    showProgress: (inProgress) {
                      cancelledTaskLoader = inProgress;

                      if (mounted) {
                        setState(() {});
                      }
                    },
                    onStatusChange: () {
                      getCancelledTaskList();
                    },
                  ),
                  separatorBuilder: (_, __) => Divider(),
                ),
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
