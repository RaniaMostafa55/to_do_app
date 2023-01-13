import 'package:flutter/material.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          color: Colors.grey,
          size: 100,
        ),
        Text(
          "No Tasks yetttttttt, Please Add Some",
          style: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
