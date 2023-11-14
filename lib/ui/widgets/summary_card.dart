import 'package:flutter/material.dart';

import '../../Style/style.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.count, required this.title,
  });
  final String count , title ;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(count,style: cardHeader(colorDarkBlue),),
            Text(title)
          ],
        ),
      ),
    );
  }
}