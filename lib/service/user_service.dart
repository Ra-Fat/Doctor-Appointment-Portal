import '../data/user_repository.dart';
import '../domain/users/user.dart';
import '../domain/users/patient.dart';
import '../domain/users/doctor.dart';

Future<List<User>> loadAndMergeUsers(UserRepository repo) async {

  // Load detailed users data
  final users = await repo.loadUserJson();

  // Load detailed patients data
  final patients = await repo.loadPatientJson();

  // Load detailed doctors data
  final doctors = await repo.loadDoctorJson();

  List<User> mergedUsers = [];

  for (var user in users) {
    if (user.role == UserRole.patient) {
      Patient? patient;
      try {
        patient = patients.firstWhere((p) => p.id == user.id);
      } catch (e) {
        patient = null;
      }

      // ai generated
      if (patient != null) {
        final mergedMap = {
          ...user.toJson(),
          'description': patient.description,
          'gender': patient.gender.name,
        };
        mergedUsers.add(Patient.fromMap(mergedMap));
      } else {
        mergedUsers.add(user);
      }
    } else if (user.role == UserRole.doctor) {
      Doctor? doctor;
      try {
        doctor = doctors.firstWhere((d) => d.id == user.id);
      } catch (e) {
        doctor = null;
      }

      // ai generated
      if (doctor != null) {
        final mergedMap = {
          ...user.toJson(),
          'specialization': doctor.specialization.name,
          'gender': doctor.gender.name,
          'availability': doctor.availability.map((a) => a.toJson()).toList(),
        };
        mergedUsers.add(Doctor.fromMap(mergedMap));
      } else {
        mergedUsers.add(user);
      }
    } else {
      mergedUsers.add(user);
    }
  }
  return mergedUsers;
}
