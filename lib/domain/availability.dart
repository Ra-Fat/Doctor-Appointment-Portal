class Availability {
  final String day;
  final DateTime startTime;
  final DateTime endTime;

  Availability({
    required this.day,
    required this.startTime,
    required this.endTime,
  }) {
    if (!startTime.isBefore(endTime)) {
      throw ArgumentError('startTime must be before endTime');
    }
  }

  // ai generated
  factory Availability.fromJson(Map<String, dynamic> json) {
    final startTimeStr = json['startTime'] as String;
    final endTimeStr = json['endTime'] as String;

    List<String> startParts = startTimeStr.split(':');
    List<String> endParts = endTimeStr.split(':');

    // ai generated
    final startTime = DateTime(
      2000,
      1,
      1,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
      int.parse(startParts[2]),
    );

    final endTime = DateTime(
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

  // ai generated
  Map<String, dynamic> toJson() {
    String _formatTime(DateTime time) {
      return '${time.hour.toString().padLeft(2, '0')}:'
             '${time.minute.toString().padLeft(2, '0')}:'
             '${time.second.toString().padLeft(2, '0')}';
    }

    return {
      'day': day,
      'startTime': _formatTime(startTime),
      'endTime': _formatTime(endTime),
    };
  }

  // ai generated
  /// Checks if the requested appointment [start] and [end] times
  bool isFit(DateTime start, DateTime end) {
    final String dayName = _getDayName(start.weekday);

    if (dayName.toLowerCase().trim() != day.toLowerCase().trim()) {
      return false;
    }

    final slotStart = DateTime(2000, 1, 1, startTime.hour, startTime.minute, startTime.second);
    final slotEnd = DateTime(2000, 1, 1, endTime.hour, endTime.minute, endTime.second);
    final appointmentStart = DateTime(2000, 1, 1, start.hour, start.minute, start.second);
    final appointmentEnd = DateTime(2000, 1, 1, end.hour, end.minute, end.second);

    return !appointmentStart.isBefore(slotStart) && !appointmentEnd.isAfter(slotEnd);
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
