import 'package:uuid/uuid.dart';


enum Gender { Male, Female }

class Patient {
  String _id;
  String _name;
  int _age;
  Gender _gender;
  String _email;
  List<String> _appointmentIds;

  String get id => _id;
  String get name => _name;
  int get age => _age;
  Gender get gender => _gender;
  String get email => _email;
  List<String> get appointmentIds => _appointmentIds;

  static final _uuid = Uuid();

  Patient(
      {String? id,
      required String name,
      required int age,
      required Gender gender,
      required List<String> appointmentIds,
      required String email})
      : _id = id ?? _uuid.v4(),
        _name = name,
        _age = age,
        _gender = gender,
        _appointmentIds = appointmentIds,
        _email = email;

  @override
  String toString() {
    return '''
      Patient ID: $_id
      Name: $_name
      Age: $_age
      Gender: ${_gender.name}
      Email: $_email
      Appointment IDs: ${_appointmentIds.isEmpty ? "No appointments" : _appointmentIds.join(", ")}
    ''';
  }
}
