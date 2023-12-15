import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_list_count.dart';
import 'package:task_manager_app/ui/controller/new_tasks_controller.dart';
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
  bool taskCountLoad = false;

  @override
  void initState() {
    Get.find<NewTaskController>().getNewTaskList();
    Get.find<NewTaskController>().getTaskListCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(const AddNewTaskScreen());
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileAppBar(),
              const SizedBox(
                height: 5,
              ),
              GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible:
                      newTaskController.getNewTaskCountInProgress == false &&
                          (newTaskController.taskListCountModel
                                  .taskListCountList?.isNotEmpty ??
                              false),
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newTaskController
                                .taskListCountModel.taskListCountList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          TaskCount taskCount = newTaskController
                              .taskListCountModel.taskListCountList![index];
                          return FittedBox(
                              child: SummaryCard(
                                  count: taskCount.sId.toString(),
                                  title: taskCount.sum.toString()));
                        }),
                  ),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              Expanded(child: bodyBackground(
                child:
                    GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        newTaskController.getNewTaskList();
                        newTaskController.getTaskListCount();
                      },
                      child: ListView.separated(
                        itemCount:
                            newTaskController.taskListModel.taskList?.length ??
                                0,
                        itemBuilder: (context, index) => TaskItemCard(
                          task:
                              newTaskController.taskListModel.taskList![index],
                          showProgress: (inProgress) {},
                          onStatusChange: () {
                            newTaskController.getNewTaskList();
                            newTaskController.getTaskListCount();
                          },
                        ),
                        separatorBuilder: (_, __) => const Divider(),
                      ),
                    ),
                  );
                }),
              ))
            ],
          ),
        ));
  }
}
