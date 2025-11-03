import 'dart:convert';
import 'dart:io';
import '../domain/doctor.dart';

class DoctorRepository{
  final String filePath;
  DoctorRepository(this.filePath);

  // Doctor getDoctorInfo(){
  //   final jsonFile = File(filePath);

  //   if(!jsonFile.existsSync()){
  //       throw Exception('file not found 404');
  //   }

  // }
}