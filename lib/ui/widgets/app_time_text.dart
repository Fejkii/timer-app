import 'package:flutter/material.dart';

class AppTimeText extends StatelessWidget {
  final String title;
  final String time;

  const AppTimeText({
    Key? key,
    required this.title,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          time,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
