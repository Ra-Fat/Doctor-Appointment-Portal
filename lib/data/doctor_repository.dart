import 'dart:convert';
import 'dart:io';
import '../domain/users/doctor.dart';

class DoctorRepository{
  final String filePath;
  List<Doctor> _doctors = [];
  DoctorRepository(this.filePath);

  List<Doctor> loadDoctorsInfo(){
    final jsonFile = File(filePath);

    if(!jsonFile.existsSync()){
        throw Exception('file not found 404');
    }
    
    // Read the whole file as String
    final jsonString = jsonFile.readAsStringSync();
    // print(jsonString);

    // convert into dart obj
    final List<dynamic> jsonList = jsonDecode(jsonString);

    // convert into Doctor obj
    _doctors = jsonList.map((json)=> Doctor.fromMap(json)).toList();

    return _doctors;
  }
}