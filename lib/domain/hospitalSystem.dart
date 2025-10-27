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


  void addDoctor() {
    
  }
  void addPatient() {

  }
  
}
