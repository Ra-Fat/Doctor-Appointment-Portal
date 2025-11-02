import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/patient.dart';
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
      {
        String? id,
        required this.doctor,
        required this.patient,
        required this.startTime,
        required this.endTime,
        AppointmentStatus? status,
        this.description
      })
      : _id = id ?? _uuid.v4(),
        status = status ?? AppointmentStatus.scheduled;

  String get id => _id;

  /// Check if this appointment conflicts with anotherAppointment
  bool conflictsWith(Appointment otherAppointment) { 
    return doctor == otherAppointment.doctor &&
        startTime.isBefore(otherAppointment.endTime) &&
        endTime.isAfter(otherAppointment.startTime);
  }

  /// Check if appointment is upcoming
  bool isUpcoming() => DateTime.now().isBefore(startTime);

  /// Check if appointment is missed
  bool isMissed() => DateTime.now().isAfter(endTime) && status != AppointmentStatus.completed && status != AppointmentStatus.cancelled;

  /// Mark appointment as completed
  void markCompleted() => status = AppointmentStatus.completed;

  /// Mark appointment as cancelled
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
