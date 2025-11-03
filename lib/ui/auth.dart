import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/patient.dart';

class Auth {
  List<Doctor> doctors;
  List<Patient> patients;

  Auth(this.doctors, this.patients);

  Doctor? loginDoctor(String username, String password, List<Doctor> doctors) {
    for (final d in doctors) {
      if (d.name == username && d.password == password) return d;
    }
    return null;
  }

  Patient? loginPatient(
      String username, String password, List<Patient> patients) {
    for (final p in patients) {
      if (p.name == username && p.password == password) return p;
    }
    return null;
  }
}
