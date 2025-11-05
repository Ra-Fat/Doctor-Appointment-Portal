import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/availability.dart';
import 'package:my_first_project/domain/appointmentManager.dart';
import 'user.dart';

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

class Doctor extends User {
  Specialization _specialization;
  List<Availability> availability;

  Specialization get specialization => _specialization;

  Doctor({
    required String id,
    required String email,
    required String password,
    required String name,
    required Gender gender,
    required Specialization specialization,
    List<Availability>? availability,
  })  : _specialization = specialization,
        availability = availability ?? [],
        super(
          id: id,
          email: email,
          password: password,
          role: UserRole.doctor,
          gender: gender,
          name: name,
        );

  factory Doctor.fromMap(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      email: (json['email'] as String?) ?? '',
      password: (json['password'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      specialization: Specialization.values.firstWhere(
        (e) => e.name == json['specialization'],
        orElse: () => Specialization.generalPractitioner,
      ),
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => Availability.fromJson(e))
          .toList(),
    );
  }


  bool isAvailable(DateTime start, DateTime end, Appointmentmanager manager) {
    List<Appointment> appointments = manager.getDoctorAppointment(this);

    if (!fitSlots) return false;

    final bool hasConflict = manager.getAllAppointmentForDoctor(this).any((a) =>
        a.conflictsWith(Appointment(
            doctor: this, patient: a.patient, startTime: start, endTime: end)));

    return !hasConflict;
  }

  @override
  String toString() {
    return '''
        Doctor ID: $id
        Name: $name
        Gender: ${gender.name}
        Specialization: ${_specialization.name}
        Email: $email
        Availability: $availability
    ''';
  }
}
