import 'dart:async';

import 'package:divelit/const/app_constants.dart';
import 'package:divelit/const/app_translations.dart';
import 'package:divelit/data/timer_model.dart';
import 'package:divelit/ui/widgets/app_text_button.dart';
import 'package:divelit/ui/widgets/app_time_slider.dart';
import 'package:divelit/ui/widgets/app_time_text.dart';
import 'package:divelit/utils/app_functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TimerModel timerModel;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  @override
  void initState() {
    DateTime initDateTime = DateTime.now();
    DateTime secondDateTime = initDateTime.add(Duration(seconds: AppConstants.initDurationintSeconds));
    int difference = secondDateTime.difference(initDateTime).inSeconds;

    timerModel = TimerModel(
      firstDateTime: initDateTime,
      secondDateTime: secondDateTime,
      actualDateTime: initDateTime,
      difference: difference,
    );

    _timer = Timer.periodic(const Duration(milliseconds: 1), (_) => _setActualDateTime()); // for show ActualDateTime

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _setActualDateTime() {
    setState(() {
      timerModel.actualDateTime = DateTime.now();
    });
  }

  void _resetTimer() {
    DateTime secondDateTime = timerModel.actualDateTime.add(Duration(seconds: AppConstants.initDurationintSeconds));
    int difference = secondDateTime.difference(timerModel.actualDateTime).inSeconds;

    timerModel.firstDateTime = timerModel.actualDateTime;
    timerModel.secondDateTime = secondDateTime;
    timerModel.difference = difference;

    // Reset widgets
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const HomePage(),
      ),
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTimeText(title: AppTranslations.startTime, time: appFormatDateTime(timerModel.firstDateTime)),
          AppTimeText(title: AppTranslations.endTime, time: appFormatDateTime(timerModel.secondDateTime)),
          const SizedBox(height: 20),
          AppTimeText(title: AppTranslations.actualTime, time: appFormatDateTime(timerModel.actualDateTime)),
          const SizedBox(height: 20),
          AppTimeSlider(timerModel: timerModel),
          const SizedBox(height: 20),
          AppTextButton(
            text: AppTranslations.resetTimer,
            onPressed: () {
              _resetTimer();
            },
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(AppTranslations.appName),
    );
  }
}
