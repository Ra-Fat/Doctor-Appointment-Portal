import 'package:my_first_project/domain/appointment.dart';
import 'package:uuid/uuid.dart';

enum Gender { Male, Female }

enum Specialization {
  generalPractitioner,
  pediatrician,
  cardiologist,
  dermatologist,
  neurologist,
  orthopedist,
  gynecologist,
  psychiatrist,
  surgeon
}

class Doctor{
  String _id;
  String _name;
  Specialization _specialization;
  String _email;
  Map<int, Appointment> _appointments;
  Gender _gender;
  int _age;

  static final _uuid = Uuid();

  String get id => _id;
  String get name => _name;
  Specialization get specialization => _specialization;
  String get email => _email;
  Map<int, Appointment> get appointments => _appointments;
  Gender get gender => _gender;
  int get age => _age;


  Doctor({
    String? id, required String name, 
    required Specialization specialization,
    required String email, Map<int, Appointment>? appointments,
    required Gender gender, required int age
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = specialization,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;


  Doctor.generalPractitioner({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.generalPractitioner,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.pediatrician({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.pediatrician,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.cardiologist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.cardiologist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.dermatologist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.dermatologist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.neurologist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.neurologist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.orthopedist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.orthopedist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.gynecologist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.gynecologist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.psychiatrist({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.psychiatrist,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

  Doctor.surgeon({
    String? id,
    required String name,
    required String email,
    Map<int, Appointment>? appointments,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.surgeon,
        _email = email,
        _appointments = appointments ?? {},
        _gender = gender,
        _age = age;

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
            '\n\t[$key] ${appt.dateTime.year}-${appt.dateTime.month.toString().padLeft(2, '0')}-${appt.dateTime.day.toString().padLeft(2, '0')} $time - ${appt.patient.name} (${appt.status})';
      });
    }

    return '''
      Doctor ID: $_id
      Name: $_name
      Specialization: ${_specialization.name}
      Age: $_age
      Gender: ${_gender.name}
      Email: $_email
      Appointments (${_appointments.length}):$appointmentsList
    ''';
  }
}
