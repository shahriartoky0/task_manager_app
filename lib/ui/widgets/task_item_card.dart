import 'package:flutter/material.dart';

import '../../Style/style.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shadowColor: Colors.green,
      child: ListTile(
        title: Text(
          'This is the title of the ListTile',
          style: cardHeader(colorDarkBlue),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This is the description '),
            SizedBox(
              height: 5,
            ),
            Text('This is the Date ',style: cardText(colorDarkBlue),),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    'New',
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
