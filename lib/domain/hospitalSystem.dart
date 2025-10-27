import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/patient.dart';

class Hospitalsystem {
  Map<String, Patient> _patients;
  Map<String, Doctor> _doctors;
  Map<String, Appointment> _appointments;

  Hospitalsystem({required Map<String, Patient> patients, required Map<String, Doctor> doctors, required Map<String, Appointment> appointments})
      : _patients = patients,
        _doctors = doctors,
        _appointments = appointments;
  
  Map<String , Patient> get patients => _patients;
  Map<String , Doctor> get doctors => _doctors;
  Map<String , Appointment> get appointments => _appointments;


  void addDoctor() {
    
  }
  void addPatient() {

  }
  
}
