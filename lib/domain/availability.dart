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
      2000, 1, 1,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
      int.parse(startParts[2]),
    );

    DateTime endTime = DateTime(
      2000, 1, 1,
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


  @override
  String toString() {
    return '$day: ${startTime.toIso8601String()} - ${endTime.toIso8601String()}';
  }
}
