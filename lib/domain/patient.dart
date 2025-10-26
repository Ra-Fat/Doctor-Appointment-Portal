import 'package:my_first_project/domain/appointment.dart';
import 'package:uuid/uuid.dart';


enum Gender { Male, Female }

class Patient {
  String _id;
  String _name;
  int _age;
  Gender _gender;
  String _email;
  Map<int, Appointment> _appointments;

  String get id => _id;
  String get name => _name;
  int get age => _age;
  Gender get gender => _gender;
  String get email => _email;
  Map<int, Appointment> get appointments => _appointments;

  static final _uuid = Uuid();

  Patient(
      {String? id,
      required String name,
      required int age,
      required Gender gender,
      required Map<int, Appointment> appointments,
      required String email})
      : _id = id ?? _uuid.v4(),
        _name = name,
        _age = age,
        _gender = gender,
        _appointments = appointments,
        _email = email;

  @override
  String toString() {
    String appointmentsList = '';
    if (_appointments.isEmpty) {
      appointmentsList = 'No appointments';
    } else {
      _appointments.forEach((key, appt) {
        final time =
            '${appt.dateTime.hour.toString().padLeft(2, '0')}:${appt.dateTime.minute.toString().padLeft(2, '0')}:${appt.dateTime.second.toString().padLeft(2, '0')}';
        appointmentsList +=
            '\n\t[$key] ${appt.dateTime.year}-${appt.dateTime.month.toString().padLeft(2, '0')}-${appt.dateTime.day.toString().padLeft(2, '0')} $time - Dr. ${appt.doctor.name} (${appt.status})';
      });
    }

    return '''
      Patient ID: $_id
      Name: $_name
      Age: $_age
      Gender: ${_gender.name}
      Email: $_email
      Appointments (${_appointments.length}):$appointmentsList
    ''';
  }
}
