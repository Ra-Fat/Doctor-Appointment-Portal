import 'dart:io';
import 'package:my_first_project/application/appointmentManager.dart';
import 'package:my_first_project/domain/users/doctor.dart';

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
      2. View Upcoming Appointments
      3. Mark Appointment Completed
      4. View patient details
      5. Logout
      """);

      stdout.write('Enter your choice: ');
      final String choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          doctor.appointments.forEach(print);
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
          break;
        case '4':
          break;
        case '5':
          print('Exiting....');
          return;
      }
    }
  }
}
