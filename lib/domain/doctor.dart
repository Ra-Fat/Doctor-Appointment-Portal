import 'package:my_first_project/domain/appointment.dart';

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

class Doctor {
  String id;
  String name;
  Specialization specialization;
  String email;
  Map<int, Appointment> appointments;
  Gender gender;
  int age;

  Doctor(
      {required this.id,
      required this.name,
      required this.specialization,
      required this.email,
      required this.appointments,
      required this.gender,
      required this.age});

  Doctor.generalPractitioner(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.generalPractitioner;

  Doctor.pediatrician(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.pediatrician;

  Doctor.cardiologist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.cardiologist;

  Doctor.dermatologist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.dermatologist;

  Doctor.neurologist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.neurologist;

  Doctor.orthopedist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.orthopedist;

  Doctor.gynecologist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.gynecologist;

  Doctor.psychiatrist(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.psychiatrist;

  Doctor.surgeon(
      this.id, this.name, this.email, this.appointments, this.gender, this.age)
      : specialization = Specialization.surgeon;

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
            '\n\t[$key] ${appt.dateTime.year}-${appt.dateTime.month.toString().padLeft(2, '0')}-${appt.dateTime.day.toString().padLeft(2, '0')} $time - ${appt.patient.name} (${appt.status})';
      });
    }

    return '''
      Doctor ID: $id
      Name: $name
      Specialization: ${specialization.name}
      Age: $age
      Gender: ${gender.name}
      Email: $email
      Appointments (${appointments.length}):$appointmentsList
    ''';
  }
}
