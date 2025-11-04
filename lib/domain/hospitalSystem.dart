// import 'users/patient.dart';
// import 'appointment.dart';

// enum Gender { Male, Female }


// class Hospitalsystem {
//   List<String> _patientIds;
//   List<String> _doctorIds;
//   List<String> _appointmentIds;

//   // Use to update the patient data
//   List<Patient> _patients = [];


//   Hospitalsystem({List<String>? patientIds, List<String>? doctorIds, List<String>? appointmentIds,})
//       : _patientIds = patientIds ?? [],
//         _doctorIds = doctorIds ?? [],
//         _appointmentIds = appointmentIds ?? [];

//   List<String> get patientIds => _patientIds;
//   List<String> get doctorIds => _doctorIds;
//   List<String> get appointmentIds => _appointmentIds;



//   void createAppointment(Appointment appointment){
//     if(!_doctorIds.contains(appointment.doctorId)){
//       print("Can not create appointmet: Doctor not found !!!");
//       return;
//     }

//     if(!_patientIds.contains(appointment.patientId)){
//       print("Can not create appointmet: Patient not found !!!");
//       return;
//     }

//     if(!_appointmentIds.contains(appointment.id)){
//       _appointmentIds.add(appointment.id);
//       print("Appointment Create Success!!!");
//     }else{
//       print("Appointment Already exist");
//     }
//   }

//   void updateAppointment(String oldAppointmentId, String newAppointmentId){
//     if(_appointmentIds.contains(oldAppointmentId)){
//       _appointmentIds[_appointmentIds.indexOf(oldAppointmentId)] = newAppointmentId;
//       print("Appointment updated from ${oldAppointmentId} to ${newAppointmentId}");
//     }else{
//       print("Appointment not found!!!");
//     }
//   }

//   void cancelAppointment(String appointmentId){
//     if(_appointmentIds.remove(appointmentId)){
//       print("Appointment ${appointmentId} cancelled");
//     }else{
//       print("Appointment not found!!");
//     }
//   }

//   void filterAppointment(){
    
//   }

//   void viewAllDoctor(){
//     print("Doctor: ${_doctorIds} \n");
//   }

//   void addPatient(Patient patient){
//     if(!_patientIds.contains(patient.id)){
//       _patientIds.add(patient.id);
//       print("Patient: ${patient.name} added to system success!!");
//     }else{
//       print("Failed to add !!!");
//     }
//   }

//   void updatePatient(String patientId, {String? name, int? age, Gender? gender, String? email}){
//      try{
//         var patient = _patients.firstWhere((p)=> p.id == patientId);

//         if(name != null){
//           patient.name = name;
//         }
//         if(age != null){
//           patient.age = age;
//         }
        
//         if(email != null){
//           patient.email = email;
//         }
//      }catch(err){
//         print("Patient not found !!!");
//      }
//   }

//   void removePatient(String patientId){
//     try{
//       var patient = _patients.firstWhere((p)=> p.id == patientId);

//       _patients.remove(patient);
//       _patientIds.remove(patientId);
//       print("Patient With ID ${patient.id} removed succesful !!!");

//     }catch(err){
//       print("Patient not found!!!");
//     }
//   }

//   void viewAllPatient(){
//     print("Patient: ${_patientIds} \n");
//   }

//   Patient? getPatientById(String patientId){
//     try{
//       return _patients.firstWhere((p)=> p.id == patientId);
//     }catch(err){
//       print("Patient not found!!!");
//     }
//     return null;
//   }
// }
