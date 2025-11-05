import 'package:my_first_project/domain/appointment.dart';

enum UserRole { patient, doctor }

enum Gender { Male, Female }

class User {
  final String id;
  final String email;
  final String password;
  final UserRole role;
  final Gender gender;
  final String name;
  List<Appointment> appointments;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.name,
    List<Appointment>? appointments,
  }) : appointments = appointments ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.toString().split('.').last == json['role'],
        orElse: () => UserRole.patient,
      ),
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
      'gender': gender.toString().split('.').last,
      'name': name,
    };
  }

  List<Appointment> getUpcomingAppointments() {
    return appointments
      .where((appointment) => appointment.isUpcoming())
      .toList();
  }

  List<Appointment> getMissedAppointments() {
      return appointments
      .where((appointment) => appointment.isMissed())
      .toList();
    }

  List<Appointment> getCancelledAppointments() {
    return appointments
      .where((appointment) => appointment.isCancelled())
      .toList();
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: ${role.toString().split('.').last}, gender: ${gender.toString().split('.').last})';
  }
}
