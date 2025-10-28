import 'doctor.dart';
import 'patient.dart';
import 'appointment.dart';


class Hospitalsystem {
  List<String> _patientIds;
  List<String> _doctorIds;
  List<String> _appointmentIds;


  Hospitalsystem({List<String>? patientIds, List<String>? doctorIds, List<String>? appointmentIds,})
      : _patientIds = patientIds ?? [],
        _doctorIds = doctorIds ?? [],
        _appointmentIds = appointmentIds ?? [];

  List<String> get patientIds => _patientIds;
  List<String> get doctorIds => _doctorIds;
  List<String> get appointmentIds => _appointmentIds;


  void addDoctor(Doctor doctor){
    if(!_doctorIds.contains(doctor.id)){
        _doctorIds.add(doctor.id);
        print("Doctor: ${doctor.name} added to system success!!");
    }else{
        print("Failed to add !!!");
    }
  }
  void addPatient(Patient patient){
    if(!_patientIds.contains(patient.id)){
      _patientIds.add(patient.id);
      print("Patient: ${patient.name} added to system success!!");
    }else{
      print("Failed to add !!!");
    }
  }

  void createAppointment(Appointment appointment){
    if(!_doctorIds.contains(appointment.doctorId)){
      print("Can not create appointmet: Doctor not found !!!");
      return;
    }

    if(!_patientIds.contains(appointment.patientId)){
      print("Can not create appointmet: Patient not found !!!");
      return;
    }

    if(!_appointmentIds.contains(appointmentIds)){
      _appointmentIds.add(appointment.id);
      print("Appointment Create Success!!!");
    }else{
      print("Appointment Already exist");
    }
  }

  void updateAppointment(String oldAppointmentId, String newAppointmentId){
    if(_appointmentIds.contains(oldAppointmentId)){
      _appointmentIds[_appointmentIds.indexOf(oldAppointmentId)] = newAppointmentId;
      print("Appointment updated from ${oldAppointmentId} to ${newAppointmentId}");
    }else{
      print("Appointment not found!!!");
    }
  }

  void cancelAppointment(String appointmentId){
    if(_appointmentIds.remove(appointmentId)){
      print("Appointment ${appointmentId} cancelled");
    }else{
      print("Appointment not found!!");
    }
  }

  void filterAppointment(){
    
  }

  void viewAllDoctor(){
    print("Doctor: ${_doctorIds} \n");
  }

  void viewAllPatient(){
    print("Patient: ${_patientIds} \n");
  }
}
