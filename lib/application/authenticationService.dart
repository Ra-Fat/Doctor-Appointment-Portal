import '../domain/users/patient.dart';
import '../domain/users/doctor.dart';
import '../domain/users/user.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthenticationService{
  final List<Patient> _patients;
  final List<Doctor> _doctors;

  User? _currentUser;

  AuthenticationService(this._patients, this._doctors);
  
  String hashPassword(String password) {
    // convert password into byte
    final bytes = utf8.encode(password);

    // hash the byte
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }

  UserRole? login(String email, String password){
    final hashedInput = hashPassword(password);

    // Check if user is patient
    for(var patient in _patients){
      if (patient.email == email && patient.password == hashedInput) {
        return UserRole.patient;
      }
    }

    // Check if user is doctor
    for (var doctor in _doctors){
      if (doctor.email == email && doctor.password == hashedInput) {
        return UserRole.doctor;
      }
    }
    return null;
  }

  void logout() {
    _currentUser = null;
  }

  User? get currentUser => _currentUser;

}
