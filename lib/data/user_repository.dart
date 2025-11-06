import 'dart:convert';
import 'dart:io';

import '../domain/users/user.dart';
import '../domain/users/patient.dart';
import '../domain/users/doctor.dart';

class UserRepository {
  final String userFilePath;
  final String patientFilePath;
  final String doctorFilePath;

  UserRepository({
    required this.userFilePath,
    required this.patientFilePath,
    required this.doctorFilePath,
  });

  Future<List<User>> loadUserJson() async {
    final file = File(userFilePath);
    // read the file and convert it into simple obj
    final jsonData = jsonDecode(await file.readAsString()) as List<dynamic>;

    // convert the simple obj into user obj
    return jsonData.map((json) => User.fromJson(json)).toList();
  }

  Future<List<Patient>> loadPatientJson() async {
    final file = File(patientFilePath);
    final jsonData = jsonDecode(await file.readAsString()) as List<dynamic>;

    // convert json maps to patient obj
    return jsonData.map((json) => Patient.fromMap(json)).toList();
  }

  Future<List<Doctor>> loadDoctorJson() async {
    final file = File(doctorFilePath);
    final jsonData = jsonDecode(await file.readAsString()) as List<dynamic>;

    // convert json maps to doctor obj
    return jsonData.map((json) => Doctor.fromMap(json)).toList();
  }
}
