import 'package:flutter/material.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';
import '../../data/models/task.dart';
import '../../data/network_caller/network_caller.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.showProgress,
    required this.onStatusChange,
  });

  final Task task;

  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shadowColor: Colors.green,
      child: ListTile(
        title: Text(
          widget.task.title ?? 'No Title',
          style: cardHeader(colorDarkBlue),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.description ?? 'No Description'),
            SizedBox(
              height: 5,
            ),
            Text(
              'Date: ${widget.task.createdDate} ',
              style: cardText(colorDarkBlue),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    '${widget.task.status}',
                    style: TextStyle(color: colorWhite),
                  ),
                  backgroundColor: colorBlue,
                ),
                SizedBox(
                  width: 160,
                ),
                IconButton(
                    onPressed: showUpdateStatusModal, icon: Icon(Icons.edit)),
                // IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
                showSnackMessage(context, 'Task Edited as ${e.name}');
              },
            ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: colorGreen,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
