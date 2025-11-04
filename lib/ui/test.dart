import '../data/doctor_repository.dart'; // Adjust import path if needed
import 'package:my_first_project/domain/users/doctor.dart';

void main() {
  final filePath = 'lib/data/doctors.json';
  final repo = DoctorRepository(filePath);

  try {
    List<Doctor> doctors = repo.loadDoctorsInfo();

    for (var doctor in doctors) {
      print(doctor);
      print('------------------');
    }
  } catch (e) {
    print('Failed to load doctors: $e');
  }
}
