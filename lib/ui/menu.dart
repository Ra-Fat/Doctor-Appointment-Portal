import 'dart:io';

import 'package:my_first_project/application/authenticationService.dart';
import 'package:my_first_project/application/appointmentManager.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:my_first_project/ui/doctorMenu.dart';
import 'package:my_first_project/ui/patientMenu.dart';

class MenuConsole {
  Appointmentmanager manager;
  List<Patient> patients;
  List<Doctor> doctors;
  AuthenticationService authService;

  MenuConsole(this.manager, this.patients, this.doctors)
      : authService = AuthenticationService(patients, doctors);

  void start() {
    while (true) {
      print('\n=== Hospital Appointment Portal ===');
      print('1. Login');
      print('2. Exit');
      stdout.write('Enter your choice: ');
      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write('Email: ');
          final String email = stdin.readLineSync() ?? '';
          stdout.write('Password: ');
          final String password = stdin.readLineSync() ?? '';

          final user = authService.login(email, password);

          if (user is Patient) {
            manager.updateMissedAppointment();
            print('Patient logged in. Redirecting to Patient Portal...');
            PatientUi(manager, user, doctors).showMenu();
          } else if (user is Doctor) {
            print('Doctor logged in. Redirecting to Doctor Portal...');
            DoctorUi(manager, user).showMenu();
          } else {
            print('Invalid email or password. Try again.');
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
