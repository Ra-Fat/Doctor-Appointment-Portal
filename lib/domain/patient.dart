import 'package:my_first_project/domain/appointment.dart';
import 'package:uuid/uuid.dart';

enum Gender { Male, Female }

class Patient {
  String _id;
  String _name;
  String _password;
  int _age;
  Gender _gender;
  String _email;
  List<Appointment> appointments = [];

  String get id => _id;
  String get name => _name;
  String get password => _password;
  int get age => _age;
  Gender get gender => _gender;
  String get email => _email;

  set name(String newName) => _name = newName;
  set age(int newAge) => _age = newAge;
  set gender(Gender newGender) => _gender = newGender;
  set email(String newEmail) => _email = newEmail;

  static final _uuid = Uuid();

  Patient(
      {String? id,
      required String name,
      required String password,
      required int age,
      required Gender gender,
      required List<String> appointmentIds,
      required String email,
      required this.appointments})
      : _id = id ?? _uuid.v4(),
        _name = name,
        _password = password,
        _age = age,
        _gender = gender,
        _email = email;

  @override
  String toString() {
    return '''
      Patient ID: $_id
      Name: $_name
      Age: $_age
      Gender: ${_gender.name}
      Email: $_email
      Appointment: @$appointments
    ''';
  }
}
