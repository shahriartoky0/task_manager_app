import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/cancelled_tasks_controller.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {



  @override
  void initState() {
    Get.find<CancelTasksController>().getCancelledTaskList();
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
            child: GetBuilder<CancelTasksController>(
              builder: (cancelTasksController) {
                return Visibility(
                  visible: cancelTasksController.cancelledTaskLoader == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cancelTasksController.getCancelledTaskList();
                    },
                    child: ListView.separated(
                      itemCount: cancelTasksController.taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) => TaskItemCard(
                        task: cancelTasksController.taskListModel.taskList![index],
                        showProgress: (inProgress) {},
                        onStatusChange: () {
                          Get.find<CancelTasksController>().getCancelledTaskList();
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
