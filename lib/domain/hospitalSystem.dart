import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/user.dart';

class Hospitalsystem {
  Map<int, Patient> patients;
  Map<int, Doctor> doctors;
  Map<int, Appointment> appointments;

  Hospitalsystem({required this.appointments, required this.doctors, required this.patients});

  void addDoctor() {
    
  }
  void addPatient() {

  }
  
}
