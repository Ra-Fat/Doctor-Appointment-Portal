import 'dart:io';

import '../lib/data/user_repository.dart';
import '../lib/domain/users/user.dart';
import '../lib/domain/users/patient.dart';
import '../lib/domain/users/doctor.dart';
import '../lib/application/authenticationService.dart';
import '../lib/application/user_service.dart';





void main() async {

  final userRepository = UserRepository(
    userFilePath: 'lib/data/json/user.json',
    patientFilePath: 'lib/data/json/patients.json',
    doctorFilePath: 'lib/data/json/doctors.json',
  );

  final users = await loadAndMergeUsers(userRepository);

  final patients = users.whereType<Patient>().toList();
  final doctors = users.whereType<Doctor>().toList();

  final authService = AuthenticationService(patients, doctors);

  print('=== Login Test ===');

  stdout.write('Email: ');
  final email = stdin.readLineSync() ?? '';

  stdout.write('Password: ');
  final password = stdin.readLineSync() ?? '';

  final role = authService.login(email.trim(), password.trim());


  if (role == null) {
    print('Login failed');
  } else if (role == UserRole.patient) {
    print('Patient logined successs!!');
  } else if (role == UserRole.doctor) {
    print('Doctor logined successs!!');
  }
}
