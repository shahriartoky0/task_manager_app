import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';

import '../../data/models/task_list_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  TaskListCountModel taskListCountModel = TaskListCountModel();
  bool completedTaskLoader = false;

  Future<void> getCompletedTaskList() async {
    completedTaskLoader = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTaskList);
    completedTaskLoader = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
  }

  @override
  void initState() {
    getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileAppBar(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: bodyBackground(
                child: Visibility(
                  visible: completedTaskLoader == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      getCompletedTaskList();
                    },
                    child: ListView.separated(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) => TaskItemCard(
                        task: taskListModel.taskList![index],
                        showProgress: (inProgress) {
                          completedTaskLoader = inProgress;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onStatusChange: () {
                          getCompletedTaskList();
                        },
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                    ),
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
