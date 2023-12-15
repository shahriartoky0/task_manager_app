import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/in_progress_tasks_controller.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {

  @override
  void initState() {
    Get.find<InProgressTasksController>().getInProgressTaskList();
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
          Expanded(child: bodyBackground(
            child: GetBuilder<InProgressTasksController>(
                builder: (inProgressTasksController) {
              return Visibility(
                visible:
                    inProgressTasksController.inProgressTaskLoader == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    inProgressTasksController.getInProgressTaskList();
                  },
                  child: ListView.separated(
                    itemCount: inProgressTasksController
                            .taskListModel.taskList?.length ??
                        0,
                    itemBuilder: (context, index) => TaskItemCard(
                      task: inProgressTasksController
                          .taskListModel.taskList![index],
                      showProgress: (inProgress) {},
                      onStatusChange: () {
                        inProgressTasksController.getInProgressTaskList();
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
