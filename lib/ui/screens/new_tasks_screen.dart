import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_list_count.dart';
import 'package:task_manager_app/data/models/task_list_count_model.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item_card.dart';

import '../widgets/summary_card.dart';
import 'add_new_tasks_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  TaskListCountModel taskListCountModel = TaskListCountModel();
  bool newTaskLoad = false;
  bool taskCountLoad = false;

  Future<void> getNewTaskList() async {
    newTaskLoad = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTaskList);
    newTaskLoad = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
  }

  Future<void> getTaskListCount() async {
    taskCountLoad = true;
    if (mounted) {
      setState(() {});
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskCount);
    taskCountLoad = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListCountModel = TaskListCountModel.fromJson(response.jsonResponse!);
    }
  }

  @override
  void initState() {
    getNewTaskList();
    getTaskListCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewTaskScreen()));
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileAppBar(),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: taskCountLoad == false &&
                    (taskListCountModel.taskListCountList?.isNotEmpty ?? false),
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          taskListCountModel.taskListCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                        TaskCount taskCount =
                            taskListCountModel.taskListCountList![index];
                        return FittedBox(
                            child: SummaryCard(
                                count: taskCount.sId.toString(),
                                title: taskCount.sum.toString()));
                      }),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: bodyBackground(
                child: Visibility(
                  visible: newTaskLoad == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async
                    {
                      getNewTaskList();
                      getTaskListCount();
                    },
                    child: ListView.separated(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) => TaskItemCard(
                        task: taskListModel.taskList![index],
                        showProgress: (inProgress) {
                          newTaskLoad = inProgress;
                          taskCountLoad =inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onStatusChange: () {
                          getNewTaskList();
                          getTaskListCount();
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
