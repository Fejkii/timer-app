import 'package:divelit/utils/app_functions.dart';
import 'package:flutter/material.dart';

class AppProfressIndicator extends StatefulWidget {
  final int time;
  const AppProfressIndicator({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  State<AppProfressIndicator> createState() => _AppProfressIndicatorState();
}

class _AppProfressIndicatorState extends State<AppProfressIndicator> with TickerProviderStateMixin {
  late AnimationController controller;
  late int initDateTime;

  @override
  void initState() {
    initDateTime = widget.time;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.time),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(1);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(appFormatDoubleToPercent(controller.value)),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: controller.value,
        )
      ],
    );
  }
}
