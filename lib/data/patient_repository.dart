import 'dart:convert';
import 'dart:io';
import '../domain/users/patient.dart';

class PatientRepository{
  final String filePath;
  List<Patient> _doctors = [];
  PatientRepository(this.filePath);

  List<Patient> loadPatientInfo(){
    final jsonFile = File(filePath);

    if(!jsonFile.existsSync()){
        throw Exception('file not found 404');
    }
    
    // Read the whole file as String
    final jsonString = jsonFile.readAsStringSync();

    // convert into dart obj
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // convert into Patient obj
    _doctors = jsonList.map((json)=> Patient.fromMap(json)).toList();

    return _doctors;
  }
}