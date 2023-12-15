import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../controller/completed_tasks_controller.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {


  @override
  void initState() {
    Get.find<CompletedTasksController>().getCompletedTaskList();
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
                child: GetBuilder<CompletedTasksController>(
                  builder: (completedTasksController) {
                    return Visibility(
                      visible: completedTasksController.completedTaskLoader == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          Get.find<CompletedTasksController>().getCompletedTaskList();
                        },
                        child: ListView.separated(
                          itemCount: completedTasksController.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) => TaskItemCard(
                            task: completedTasksController.taskListModel.taskList![index],
                            showProgress: (inProgress) {},
                            onStatusChange: () {
                              Get.find<CompletedTasksController>().getCompletedTaskList();
                            },
                          ),
                          separatorBuilder: (_, __) => const Divider(),
                        ),
                      ),
                    );
                  }
                ),
              ))
        ],
      ),
    ));
  }
}
