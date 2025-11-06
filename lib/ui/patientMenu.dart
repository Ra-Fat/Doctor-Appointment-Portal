import 'dart:io';

import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/service/appointment_manager.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:my_first_project/data/appointment_data.dart';

class PatientUi {
  final Appointmentmanager manager;
  final Patient patient;
  final List<Doctor> doctors;
  final AppointmentRepository appointmentRepo;

  PatientUi(this.manager, this.patient, this.doctors, this.appointmentRepo);

 Future<void> showMenu() async {
    while (true) {
      print("""
      --- Patient Portal ---
        1. View Upcoming Appointments
        2. View Missed Appointments
        3. View Cancelled Appointments
        4. Schedule Appointment
        5. Cancel Appointment
        6. Reschedule Appointment
        7. Exit
      """);
      stdout.write('Enter your choice: ');
      final String choice = stdin.readLineSync() ?? '';

      switch (choice) {
        case '1':
          final List<Appointment> upComing = patient.getUpcomingAppointments();

          if (upComing.isEmpty) {
            print("No upcoming appointments.");
          } else {
            //ai-generated
            print('\nUpcoming Appointments:');
            for (var appointment in upComing) {
              final date =
                  '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print('- $date at $time with Dr. ${appointment.doctor.name}');
            }
          }
          break;
        case '2':
          final List<Appointment> missed = patient.getMissedAppointments();

          if (missed.isEmpty) {
            print("No missed appointments.");
          } else {
            print('\nMissed Appointments:');
            for (var appointment in missed) {
              //ai-generated
              final date =
                  '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print('- $date at $time with Dr. ${appointment.doctor.name}');
            }
          }
          break;
        case '3':
          final List<Appointment> cancelled =
              patient.getCancelledAppointments();

          if (cancelled.isEmpty) {
            print("No cancelled appointments.");
          } else {
            print('\nCancelled Appointments:');
            for (var appointment in cancelled) {
              //ai-generated
              final date =
                  '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print('- $date at $time with Dr. ${appointment.doctor.name}');
            }
          }
          break;
        case '4':
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

            stdout.write('Enter description for the appointment: ');
            final description = stdin.readLineSync();

            if (manager.scheduleAppointment(patient, selectedDoctor, start, end, description: description)){
                await appointmentRepo.saveAppointments(manager.appointments);
                print('Appointment scheduled successfully!');
              } else {
                print('Failed to schedule appointment.');
              }
          } catch (e) {
            print('Invalid input. Please try again.');
          }
          break;

        case '5':
          final cancellableAppointments = patient.appointments
              .where((appointment) =>
                  appointment.status == AppointmentStatus.scheduled &&
                  appointment.startTime.isAfter(DateTime.now()))
              .toList();

          if (cancellableAppointments.isEmpty) {
            print('No appointments available to cancel.');
            break;
          }
          print('\nYour cancellable appointments:');
          for (int i = 0; i < cancellableAppointments.length; i++) {
            final Appointment appointment = cancellableAppointments[i];
            //ai-generated
            final date =
                '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
            final time =
                '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
            print(
                '${i + 1}. $date at $time with Dr. ${appointment.doctor.name}');
          }

          stdout.write('Enter appointment number to cancel: ');
          final String input = stdin.readLineSync() ?? '';

          try {
            int index = int.parse(input);
            if (index < 1 || index > cancellableAppointments.length) {
              print('Invalid selection.');
            } else {
              final appointment = cancellableAppointments[index - 1];
              if (manager.cancelAppointment(appointment)) {
                await appointmentRepo.saveAppointments(manager.appointments);
                print('Appointment cancelled successfully.');
              }
            }
          } catch (e) {
            print('Please enter a valid number.');
          }

          break;
        case '6':
          try {
            final reschedulableAppointments = patient.appointments
                .where((appointment) => appointment.canBeRescheduled())
                .toList();

            if (reschedulableAppointments.isEmpty) {
              print('No appointments available to reschedule.');
              break;
            }

            print('\nYour reschedulable appointments:');
            for (int i = 0; i < reschedulableAppointments.length; i++) {
              final appointment = reschedulableAppointments[i];
              //ai-generated
              final date =
                  '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print(
                  '${i + 1}. $date at $time with Dr. ${appointment.doctor.name}');
            }

            stdout.write('Enter appointment number to reschedule: ');
            final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

            if (index < 1 || index > reschedulableAppointments.length) {
              print('Invalid selection.');
              break;
            }

            final appointment = reschedulableAppointments[index - 1];

            stdout.write('Enter new start time (YYYY-MM-DD HH:MM): ');
            final newStart =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            stdout.write('Enter new end time (YYYY-MM-DD HH:MM): ');
            final newEnd =
                DateTime.parse(stdin.readLineSync()!.replaceFirst(' ', 'T'));

            if (manager.rescheduleAppointment(appointment, newStart, newEnd)) {
              print('Appointment rescheduled successfully.');
              await appointmentRepo.saveAppointments(manager.appointments);
            } else {
              print('Failed to reschedule appointment.');
            }
          } catch (e) {
            print('Invalid input. Please try again.');
          }
          break;
        case '7':
          print('Exiting.....');
          return;
      }
    }
  }
}
