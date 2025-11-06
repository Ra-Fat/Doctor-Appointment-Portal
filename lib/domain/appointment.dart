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

  // Factory constructor for create appointment obj
  factory Appointment.fromJson(Map<String, dynamic> json, Doctor doctor, Patient patient) {
    return Appointment(
      id: json['id'],
      doctor: doctor,
      patient: patient,
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => AppointmentStatus.scheduled,
      ),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctor.id,
      'patientId': patient.id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status.toString().split('.').last,
      'description': description,
    };
  }

  // checking conflic time of appointments w the same doctor
  bool conflictsWith(Appointment appointment) {
    bool conflict = doctor == appointment.doctor &&
        startTime.isBefore(appointment.endTime) &&
        endTime.isAfter(appointment.startTime);
    return conflict;
  }

  // checking the upcoming appointments
  bool isUpcoming() => DateTime.now().isBefore(startTime);

  // checking the missed appointments
  bool isMissed() {
    final gracePeriod = endTime.add(Duration(hours: 24));
    return DateTime.now().isAfter(gracePeriod) &&
        status != AppointmentStatus.completed &&
        status != AppointmentStatus.cancelled;
  }

  // checking the cancelled appointments
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
    Doctor: ${doctor.name}
    Patient: ${patient.name}
  ''';
  }
}
