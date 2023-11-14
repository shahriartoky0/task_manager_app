import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';

import '../widgets/profile_app_bar.dart';
import '../widgets/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ProfileAppBar(),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: bodyBackground(
                    child: ListView.separated(
                      itemCount: 10,
                      itemBuilder: (context, builder) => TaskItemCard(),
                      separatorBuilder: (_, __) => Divider(),
                    ),
                  ))
            ],
          ),
        ));
  }
}
