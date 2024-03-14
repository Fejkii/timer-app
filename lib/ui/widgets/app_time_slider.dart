import 'package:divelit/const/app_translations.dart';
import 'package:divelit/ui/widgets/app_time_text.dart';
import 'package:flutter/material.dart';
import 'package:divelit/data/timer_model.dart';
import 'package:divelit/utils/app_functions.dart';

class AppTimeSlider extends StatefulWidget {
  final TimerModel timerModel;

  const AppTimeSlider({
    Key? key,
    required this.timerModel,
  }) : super(key: key);

  @override
  State<AppTimeSlider> createState() => _AppTimeSliderState();
}

class _AppTimeSliderState extends State<AppTimeSlider> with TickerProviderStateMixin {
  late TimerModel timerModel;
  late AnimationController _sliderController;
  late double _currentSliderValue;

  @override
  void initState() {
    _currentSliderValue = 0;
    timerModel = widget.timerModel;

    _sliderController = AnimationController(
      vsync: this,
      duration: Duration(seconds: timerModel.difference),
    )..addListener(() {
        setState(() {
          _currentSliderValue = _sliderController.value;
        });
      });

    _startSlider();

    super.initState();
  }

  @override
  void dispose() {
    _sliderController.dispose();

    super.dispose();
  }

  void _stopSlider() {
    _sliderController.stop();
  }

  void _startSlider() {
    _sliderController.animateTo(1);
  }

  void _resetSlider(double value) {
    setState(() {
      _sliderController.value = value;
    });
  }

  void _changeFirstTime() {
    if (timerModel.actualDateTime.isBefore(timerModel.secondDateTime)) {
      int diffMilliseconds = timerModel.secondDateTime.difference(timerModel.actualDateTime).inMilliseconds;
      double diffPercent = 1 - _currentSliderValue;
      double changedMilliseconds = diffMilliseconds * diffPercent;
      DateTime newStartTime = timerModel.actualDateTime.subtract(Duration(milliseconds: changedMilliseconds.toInt()));
      setState(() {
        timerModel.firstDateTime = newStartTime;
        _sliderController.animateTo(1, duration: Duration(milliseconds: diffMilliseconds));
      });
    }
  }

  void _cahngeSencodTime() {
    if (timerModel.actualDateTime.isAfter(timerModel.secondDateTime)) {
      int diffMiliseconds = timerModel.actualDateTime.difference(timerModel.firstDateTime).inMilliseconds;
      double diffPercent = 1 - _currentSliderValue;
      double changedMilliseconds = diffMiliseconds * diffPercent;
      DateTime newEndTime = timerModel.actualDateTime.add(Duration(milliseconds: changedMilliseconds.toInt()));

      setState(() {
        timerModel.secondDateTime = newEndTime;
        _sliderController.animateTo(1, duration: Duration(milliseconds: changedMilliseconds.toInt()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTimeText(title: AppTranslations.percentageOfTime, time: appFormatDoubleToPercent(_sliderController.value)),
        Slider(
          value: _currentSliderValue,
          divisions: 1000,
          label: appFormatDoubleToPercent(_currentSliderValue),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
          onChangeStart: (double value) {
            _stopSlider();
          },
          onChangeEnd: (double value) {
            _resetSlider(value);
            _changeFirstTime();
            _cahngeSencodTime();
          },
        ),
      ],
    );
  }
}
