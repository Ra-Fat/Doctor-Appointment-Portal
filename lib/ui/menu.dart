import 'dart:io';

import 'package:my_first_project/domain/appointmentManager.dart';
import 'package:my_first_project/domain/Doctor.dart';
import 'package:my_first_project/domain/patient.dart';
import 'package:my_first_project/ui/doctorUI.dart';
import 'package:my_first_project/ui/patientUI.dart';

class MenuConsole {
  Appointmentmanager manager;
  Patient patients;
  List<Doctor> doctors;

  MenuConsole(this.manager, this.patients, this.doctors);

  void main() {
    while (true) {
      print('\n=== Hospital Appointment Portal ===');
      print('1. Login');
      print('2. Exit');
      stdout.write('Enter your choice: ');
      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write('Username: ');
          final username = stdin.readLineSync() ?? '';
          stdout.write('Password: ');
          final password = stdin.readLineSync() ?? '';

          if (username.startsWith('patient') && password.isNotEmpty) {
            print('Patient logged in. Redirecting to Patient Portal...');
            PatientUi(manager,patients, doctors).showMenu();
          } else if (username.startsWith('doctor')) {
            print('Doctor logged in. Redirecting to Doctor Portal...');
            DoctorUi(manager, doctors).showMenu();
          } else {
            print('Invalid username or password. Try again.');
          }
          break;

        case '2':
          print('Exiting... Goodbye!');
          return;

        default:
          print('Invalid choice. Try again.');
      }
    }
  }
}
