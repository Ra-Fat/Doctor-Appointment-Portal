import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:uuid/uuid.dart';

enum AppointmentStatus {
  scheduled,
  completed,
  cancelled,
  missed,
}

class Appointment {
  String _id;
  Doctor doctor;
  Patient patient;
  DateTime startTime;
  DateTime endTime;
  AppointmentStatus status;
  String? description;

  static final _uuid = Uuid();

  Appointment(
      {String? id,
      required this.doctor,
      required this.patient,
      required this.startTime,
      required this.endTime,
      AppointmentStatus? status,
      this.description})
      : _id = id ?? _uuid.v4(),
        status = status ?? AppointmentStatus.scheduled;

  String get id => _id;

  bool conflictsWith(Appointment appointment) {
    return doctor == appointment.doctor &&
        startTime.isBefore(appointment.endTime) &&
        endTime.isAfter(appointment.startTime);
  }

  bool isUpcoming() => DateTime.now().isBefore(startTime);

  bool isMissed() {
    // Add 24-hour grace period for doctors to mark appointment as completed
    final gracePeriod = endTime.add(Duration(hours: 24));
    return DateTime.now().isAfter(gracePeriod) &&
        status != AppointmentStatus.completed &&
        status != AppointmentStatus.cancelled;
  }

  bool isCancelled() => status == AppointmentStatus.cancelled;

  bool canBeRescheduled() =>
      status == AppointmentStatus.scheduled &&
      DateTime.now().isBefore(startTime);

  void markCompleted() => status = AppointmentStatus.completed;

  void markCancelled() => status = AppointmentStatus.cancelled;

  @override
  String toString() {
    return '''
    Appointment ID: $id
    Start Time: $startTime
    End Time: $endTime
    Status: $status
    Description: $description
    Doctor: ${doctor}
    Patient: ${patient}
  ''';
  }
}
