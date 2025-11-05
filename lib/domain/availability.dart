class Availability {
  String day;
  DateTime startTime;
  DateTime endTime;

  Availability({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    String startTimeStr = json['startTime'] as String;
    String endTimeStr = json['endTime'] as String;

    // Parse "HH:mm:ss"
    List<String> startParts = startTimeStr.split(':');
    List<String> endParts = endTimeStr.split(':');

    DateTime startTime = DateTime(
      2000,
      1,
      1,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
      int.parse(startParts[2]),
    );

    DateTime endTime = DateTime(
      2000,
      1,
      1,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
      int.parse(endParts[2]),
    );

    return Availability(
      day: json['day'] as String,
      startTime: startTime,
      endTime: endTime,
    );
  }

  bool isFit(DateTime start, DateTime end) {
    final String dayName = _getDayName(start.weekday);
    if (dayName != day) {
      return false;
    }

    // Extract time-of-day from appointment (ignore actual date)
    // Normalize to year 2000 to compare against availability times
    final appointmentStart = DateTime(2000, 1, 1, start.hour, start.minute);
    final appointmentEnd = DateTime(2000, 1, 1, end.hour, end.minute);

    return !appointmentStart.isBefore(startTime) &&
        !appointmentEnd.isAfter(endTime);
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }
}
