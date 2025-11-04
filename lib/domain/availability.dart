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
    return Availability(
      day: json['day'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }

  @override
  String toString() {
    return '$day: ${startTime.toIso8601String()} - ${endTime.toIso8601String()}';
  }
}
