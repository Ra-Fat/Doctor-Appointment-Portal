import 'package:my_first_project/domain/patient.dart';
import 'package:uuid/uuid.dart';


class Appointment {
  String _id;
  String _doctorId;
  String _patientId;
  DateTime _dateTime;
  String _status;
  String _description;


  static final _uuid = Uuid();

  Appointment(
      {String? id,
      required DateTime dateTime,
      required String status,
      required String description,
      required String doctorId,
      required Patient patientId})
      : _id = id ?? _uuid.v4(),
        _dateTime = dateTime,
        _status = status,
        _description = description,
        _doctorId = doctorId,
        _patientId = patientId.id;



  String get id => _id;
  DateTime get dateTime => _dateTime;
  String get status => _status;
  String get description => _description;
  String get doctorId => _doctorId;
  String get patientId => _patientId;

  @override
  String toString() {
    return '''
    Appointment ID: $_id
    Date & Time: $_dateTime
    Status: $_status
    Description: $_description
    Doctor: ${_doctorId}
    Patient: ${_patientId}
  ''';
  }
}
