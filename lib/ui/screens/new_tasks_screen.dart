import 'package:flutter/material.dart';
import 'package:task_manager_app/Style/style.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
        },
        ),
        body: SafeArea(
          child: Column(
            children: [
              ProfileAppBar(),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SummaryCard(
                        count: '09',
                        title: 'Canceled',
                      ),
                      SummaryCard(
                        count: '13',
                        title: 'Completed',
                      ),
                      SummaryCard(
                        count: '7',
                        title: 'Progress',
                      ),
                      SummaryCard(
                        count: '5',
                        title: 'New Task',
                      ),
                      SummaryCard(
                        count: '2',
                        title: 'New Task',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: bodyBackground(
                    child: ListView.separated(
                      itemCount: 3,
                      itemBuilder: (context, builder) => TaskItemCard(),
                      separatorBuilder: (_, __) => Divider(),
                    ),
                  ))
            ],
          ),
        ));
  }
}
