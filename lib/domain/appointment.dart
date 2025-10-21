import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/user.dart';

class Appointment {
  String id;
  DateTime dateTime;
  String status;
  String description;
  Patient patient;
  Doctor doctor;

  Appointment(
      {required this.id,
      required this.dateTime,
      required this.status,
      required this.description,
      required this.doctor,
      required this.patient});

  @override
  String toString() {
    return '''
    Appointment ID: $id
    Date & Time: $dateTime
    Status: $status
    Description: $description
    Doctor: ${doctor.name}
    Patient: ${patient.name}
  ''';
  }
}
