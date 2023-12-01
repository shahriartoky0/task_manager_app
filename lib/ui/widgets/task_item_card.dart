import 'package:flutter/material.dart';
import '../../Style/style.dart';
import '../../data/models/task.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key, required this.task,
  });
  final Task task ;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shadowColor: Colors.green,
      child: ListTile(
        title: Text(
          task.title ?? 'No Title',
          style: cardHeader(colorDarkBlue),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description?? 'No Description'),
            SizedBox(
              height: 5,
            ),
            Text('Date: ${task.createdDate} ',style: cardText(colorDarkBlue),),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    '${task.status}',
                    style: TextStyle(color: colorWhite),
                  ),
                  backgroundColor: colorBlue,
                ),
                SizedBox(width: 180,),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
