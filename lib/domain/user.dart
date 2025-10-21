import 'package:my_first_project/domain/appointment.dart';

enum Gender { Male, Female }

class Patient {
  String id;
  String name;
  int age;
  Gender gender;
  String email;
  Map<int, Appointment> appointments;

  Patient(
      {required this.id,
      required this.name,
      required this.age,
      required this.gender,
      required this.appointments,
      required this.email});

  @override
  String toString() {
    String appointmentsList = '';
    if (appointments.isEmpty) {
      appointmentsList = 'No appointments';
    } else {
      appointments.forEach((key, appt) {
        final time =
            '${appt.dateTime.hour.toString().padLeft(2, '0')}:${appt.dateTime.minute.toString().padLeft(2, '0')}:${appt.dateTime.second.toString().padLeft(2, '0')}';
        appointmentsList +=
            '\n\t[$key] ${appt.dateTime.year}-${appt.dateTime.month.toString().padLeft(2, '0')}-${appt.dateTime.day.toString().padLeft(2, '0')} $time - Dr. ${appt.doctor.name} (${appt.status})';
      });
    }

    return '''
      Patient ID: $id
      Name: $name
      Age: $age
      Gender: ${gender.name}
      Email: $email
      Appointments (${appointments.length}):$appointmentsList
    ''';
  }
}
