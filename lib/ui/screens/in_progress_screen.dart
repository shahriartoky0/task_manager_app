import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';

import '../../data/models/task_list_count_model.dart';
import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  TaskListModel taskListModel = TaskListModel();
  TaskListCountModel taskListCountModel = TaskListCountModel();
  bool inProgressTaskLoader = false;

  Future<void> getInProgressTaskList() async {
    inProgressTaskLoader = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTaskList);
    inProgressTaskLoader = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
  }

  @override
  void initState() {
    getInProgressTaskList();
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
              visible: inProgressTaskLoader == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  getInProgressTaskList();
                },
                child: ListView.separated(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) => TaskItemCard(
                    task: taskListModel.taskList![index],
                    showProgress: (inProgress) {
                      inProgressTaskLoader = inProgress;

                      if (mounted) {
                        setState(() {});
                      }
                    },
                    onStatusChange: () {
                      getInProgressTaskList();
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
