// menu.dart
import 'dart:io';

import 'package:my_first_project/service/authentication_service.dart';
import 'package:my_first_project/service/appointment_manager.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:my_first_project/ui/doctorMenu.dart';
import 'package:my_first_project/ui/patientMenu.dart';
import 'package:my_first_project/data/appointment_data.dart';

class MenuConsole {
  Appointmentmanager manager;
  List<Patient> patients;
  List<Doctor> doctors;
  AppointmentRepository appointmentRepo;
  AuthenticationService authService;

  MenuConsole(this.manager, this.patients, this.doctors, this.appointmentRepo)
      : authService = AuthenticationService(patients, doctors);

  Future<void> start() async {
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
            await PatientUi(manager, user, doctors, appointmentRepo).showMenu();
          } else if (user is Doctor) {
            print('Doctor logged in. Redirecting to Doctor Portal...');
            await DoctorUi(manager, user, appointmentRepo).showMenu();
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
