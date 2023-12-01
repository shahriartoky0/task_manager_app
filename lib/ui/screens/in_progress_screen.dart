import 'package:flutter/material.dart';
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
