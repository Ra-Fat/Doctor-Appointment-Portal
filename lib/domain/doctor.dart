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
  List<String> _appointmentsIds;
  Gender _gender;
  int _age;

  static final _uuid = Uuid();

  String get id => _id;
  String get name => _name;
  Specialization get specialization => _specialization;
  String get email => _email;
  List<String> get appointments => _appointmentsIds;
  Gender get gender => _gender;
  int get age => _age;


  Doctor({
    String? id, required String name, 
    required Specialization specialization,
    required String email, List<String>? appointmentIds,
    required Gender gender, required int age
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = specialization,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;


  Doctor.generalPractitioner({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.generalPractitioner,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.pediatrician({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
    }): 
        _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.pediatrician,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.cardiologist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.cardiologist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.dermatologist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.dermatologist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.neurologist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.neurologist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.orthopedist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.orthopedist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.gynecologist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.gynecologist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.psychiatrist({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.psychiatrist,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;

  Doctor.surgeon({
    String? id,
    required String name,
    required String email,
    List<String>? appointmentIds,
    required Gender gender,
    required int age,
  })  : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = Specialization.surgeon,
        _email = email,
        _appointmentsIds = appointmentIds ?? [],
        _gender = gender,
        _age = age;


  @override
  String toString() {
    return '''
      Doctor ID: $_id
      Name: $_name
      Specialization: ${_specialization.name}
      Age: $_age
      Gender: ${_gender.name}
      Email: $_email
      Appointment IDs: ${_appointmentsIds.isEmpty ? "No appointments" : _appointmentsIds.join(", ")}
    ''';
  }
}
