class TimerModel {
  DateTime firstDateTime;
  DateTime secondDateTime;
  DateTime actualDateTime;
  int difference;

  TimerModel({
    required this.firstDateTime,
    required this.secondDateTime,
    required this.actualDateTime,
    required this.difference,
  });
}
