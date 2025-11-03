import 'dart:io';

import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/appointmentManager.dart';
import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/patient.dart';

class PatientUi {
  final Appointmentmanager manager;
  final Patient patient;
  final List<Doctor> doctors;

  PatientUi(this.manager, this.patient, this.doctors);

  void showMenu() {
    while (true) {
      //Ai-generated
      print("""
      --- Patient Portal ---
        1. View Upcoming Appointments
        2. Schedule Appointment
        3. Cancel Appointment
        4. Reschedule Appointment
        5. Exit
      """);

      String choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          final List<Appointment> appointments =
              manager.getAllAppointmentForPatient(patient);
          final List<Appointment> upComing =
              manager.getUpcomingAppointments(appointments);

          if (upComing.isEmpty) {
            print("No upcoming appointments.");
          } else {
            //ai-generated
            print('\nUpcoming Appointments:');
            for (var a in upComing) {
              print('- ${a.startTime} with Dr. ${a.doctor.name}');
            }
          }
          break;

        case '2':
          try {
            stdout.write('Enter appointment start time (YYYY-MM-DD HH:MM): ');
            final start =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            stdout.write('Enter appointment end time (YYYY-MM-DD HH:MM): ');
            final end =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            final List<Doctor> availableDoctors =
                manager.getAvailableDoctors(start, end, doctors);

            if (availableDoctors.isEmpty) {
              print('No doctors available for this time slot.');
              break;
            }
            //ai-generated
            print('\nAvailable Doctors:');
            for (int i = 0; i < availableDoctors.length; i++) {
              print(
                  '${i + 1}. ${availableDoctors[i].name} - ${availableDoctors[i].specialization}');
            }

            stdout.write('Select doctor number: ');
            final doctorIndex = int.parse(stdin.readLineSync() ?? '');

            if (doctorIndex < 1 || doctorIndex > availableDoctors.length) {
              print('Invalid selection.');
              break;
            }

            final selectedDoctor = availableDoctors[doctorIndex - 1];

            if (manager.scheduleAppointment(
                patient, selectedDoctor, start, end)) {
              print('Appointment scheduled successfully!');
            } else {
              print('Failed to schedule appointment.');
            }
          } catch (e) {
            print('Invalid input. Please try again.');
          }
          break;

        case '3':
          final List<Appointment> appointments =
              manager.getAllAppointmentForPatient(patient);
          if (appointments.isEmpty) {
            print('No appointment to cancel');
            break;
          }
          print('\nYour appointments:');
          for (int i = 0; i < appointments.length; i++) {
            final Appointment appointment = appointments[i];
            print(
                '${i + 1}. Appointment start at: ${appointment.startTime} with Dr. ${appointment.doctor.name}');
          }

          stdout.write('Enter appointment number to cancel: ');
          final String input = stdin.readLineSync() ?? '';

          try {
            int index = int.parse(input);
            if (index < 1 || index > appointments.length) {
              print('Invalid selection.');
            } else {
              final appointment = appointments[index - 1];
              manager.cancelAppointment(appointment);
              print('Appointment cancelled.');
            }
          } catch (e) {
            print('Please enter a valid number.');
          }

          break;
        case '4':
          try {
            final appointments = manager.getAllAppointmentForPatient(patient);
            if (appointments.isEmpty) {
              print('No appointments to reschedule.');
              break;
            }

            print('\nYour Appointments:');
            for (int i = 0; i < appointments.length; i++) {
              final a = appointments[i];
              print('${i + 1}. ${a.startTime} with Dr. ${a.doctor.name}');
            }

            stdout.write('Enter appointment number to reschedule: ');
            final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

            if (index < 1 || index > appointments.length) {
              print('Invalid selection.');
              break;
            }

            final appointment = appointments[index - 1];

            stdout.write('Enter new start time (YYYY-MM-DD HH:MM): ');
            final newStart =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            stdout.write('Enter new end time (YYYY-MM-DD HH:MM): ');
            final newEnd =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            if (manager.rescheduleAppointment(appointment, newStart, newEnd)) {
              print('Appointment rescheduled successfully.');
            } else {
              print('Failed to reschedule appointment.');
            }
          } catch (e) {
            print('Invalid input. Please try again.');
          }
          break;
        case '5':
          print('Exiting.....');
          return;
      }
    }
  }
}
