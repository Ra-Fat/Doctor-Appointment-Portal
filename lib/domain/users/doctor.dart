import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/availability.dart';
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
    required int age,
    required Specialization specialization,
    List<Availability>? availability,
    List<Appointment>? appointments,
  })  : _specialization = specialization,
        availability = availability ?? [],
        super(
          id: id,
          email: email,
          password: password,
          role: UserRole.doctor,
          gender: gender,
          name: name,
          age: age,
          appointments: appointments ?? [],
        );

  // Factory constructor for create doctor obj
  factory Doctor.fromMap(Map<String, dynamic> json) {
    
    final availabilityList = (json['availability'] as List<dynamic>?)
        ?.map((e) => Availability.fromJson(e))
        .toList() ?? [];

    return Doctor(
      id: json['id'] as String,
      email: (json['email'] as String?) ?? '',
      password: (json['password'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      age: json['age'] != null ? json['age'] as int : 0,
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      specialization: Specialization.values.firstWhere(
        (e) => e.name == json['specialization'],
        orElse: () => Specialization.generalPractitioner,
      ),
      availability: availabilityList,
    );
  }

  // Checks if the doctor is available
  bool isAvailable(DateTime start, DateTime end) {

    final availabilityFits = availability.any((slot) {
      return slot.isFit(start, end);
    });

    if (!availabilityFits) {
      return false;
    }

    final hasConflict = appointments.any((existing) =>
      existing.conflictsWith(Appointment(
        doctor: this,
        patient: existing.patient,
        startTime: start,
        endTime: end,
      ))
    );

    return !hasConflict;
  }
}
