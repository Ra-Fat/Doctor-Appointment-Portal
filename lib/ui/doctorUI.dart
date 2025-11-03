import 'dart:io';

import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/appointmentManager.dart';
import 'package:my_first_project/domain/doctor.dart';

class DoctorUi {
  final Appointmentmanager manager;
  final Doctor doctor;

  DoctorUi(this.manager, this.doctor);

  void showMenu() {
    while (true) {
      //Ai-generated
      print("""
      --- Doctor Portal ---
      1. View Today's Appointments
      2. Mark Appointment Completed
      3. Logout
      """);

      String choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          final appointments = manager.getAllAppointmentForDoctor(doctor);
          appointments.forEach(print);
          break;
        case '2':
          // print('Enter appointment ID to mark as completed:');
          // String? appointmentId = stdin.readLineSync();
          // if (appointmentId != null && appointmentId.isNotEmpty) {
          //   manager.completeAppointment(appointmentId);
          //   print('Appointment marked as completed.');
          // } else {
          //   print('Invalid appointment ID.');
          // }
          // break;
        case '3':
          print('Exiting.....');
          return;
      }
    }
  }
}
