import 'dart:convert';
import 'dart:io';

import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';

class AppointmentRepository {
  final String filePath;

  AppointmentRepository(this.filePath);

  // read the appointment file
  Future<List<Appointment>> loadAppointments(List<Doctor> doctors, List<Patient> patients) async {
    final file = File(filePath);

    if (!await file.exists()) return [];

    // string format after read
    final stringFormat = await file.readAsString();
    
    // decode to dynamic list
    final List<dynamic> listFormat = jsonDecode(stringFormat);

    List<Appointment> appointments = [];

    for (var json in listFormat) {
      final doctor = doctors.firstWhere((d) => d.id == json['doctorId']);
      final patient = patients.firstWhere((p) => p.id == json['patientId']);

      final appointment = Appointment.fromJson(json, doctor, patient);
      appointments.add(appointment);

      // Link appointments for doctor and patient
      doctor.appointments.add(appointment);
      patient.appointments.add(appointment);
    }

    return appointments;
  }

  // write data back to file
  Future<void> saveAppointments(List<Appointment> appointments) async {
    final file = File(filePath);

    // ISO string without microseconds
    String formatDateTime(DateTime dt) => dt.toIso8601String().split('.').first;
    
    // format we want
    final jsonList = appointments.map((a) => {
          'id': a.id,
          'doctorId': a.doctor.id,
          'patientId': a.patient.id,
          'startTime': formatDateTime(a.startTime),
          'endTime': formatDateTime(a.endTime),
          'status': a.status.toString().split('.').last,
          'description': a.description,
        }).toList();

    final encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(jsonList);

    // write in json String
    await file.writeAsString(prettyJson);
  }
}
