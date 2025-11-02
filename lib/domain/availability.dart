class Availability {
  String day;
  DateTime startTime;
  DateTime endTime;

  Availability(
      {required this.day, required this.startTime, required this.endTime});

  bool isFits(DateTime startTime, DateTime endTime) {
    return startTime.isAfter(startTime) && endTime.isBefore(endTime);
  }
}
