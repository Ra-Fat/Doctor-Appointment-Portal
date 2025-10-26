import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/patient.dart';
import 'package:uuid/uuid.dart';


class Appointment {
  String _id;
  DateTime _dateTime;
  String _status;
  String _description;
  Patient _patient;
  Doctor _doctor;

  static final _uuid = Uuid();

  Appointment(
      {String? id,
      required DateTime dateTime,
      required String status,
      required String description,
      required Doctor doctor,
      required Patient patient})
      : _id = id ?? _uuid.v4(),
        _dateTime = dateTime,
        _status = status,
        _description = description,
        _doctor = doctor,
        _patient = patient;

  String get id => _id;
  DateTime get dateTime => _dateTime;
  String get status => _status;
  String get description => _description;
  Patient get patient => _patient;
  Doctor get doctor => _doctor;

  @override
  String toString() {
    return '''
    Appointment ID: $_id
    Date & Time: $_dateTime
    Status: $_status
    Description: $_description
    Doctor: ${_doctor.name}
    Patient: ${_patient.name}
  ''';
  }
}
