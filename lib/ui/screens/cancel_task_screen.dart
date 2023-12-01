import 'package:flutter/material.dart';
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
                    child: ListView .separated(
                      itemCount: 10,
                      itemBuilder: (context, builder) {
                        // return TaskItemCard()

                      },
                      separatorBuilder: (_, __) => Divider(),
                    ),
                  ))
            ],
          ),
        ));
  }
}
