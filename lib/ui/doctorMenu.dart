import 'dart:io';
import 'package:my_first_project/domain/appointment.dart';
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
          final today = DateTime.now();
          final todaysAppointments = doctor.appointments.where((appointment) {
            final appointmentDate = appointment.startTime;
            return appointmentDate.year == today.year &&
                appointmentDate.month == today.month &&
                appointmentDate.day == today.day &&
                appointment.status == AppointmentStatus.scheduled;
          }).toList();

          // ai-generated
          if (todaysAppointments.isEmpty) {
            print('No appointments today!');
          } else {
            print("\nToday's Appointments:");
            for (Appointment appointment in todaysAppointments) {
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print('- $time with ${appointment.patient.name}');
            }
          }
          break;
        case '2':
          final upcomingAppointments = doctor.getUpcomingAppointments();

          if (upcomingAppointments.isEmpty) {
            print('No upcoming appointments.');
          } else {
            // ai-generated
            print('\nUpcoming Appointments:');
            for (var appointment in upcomingAppointments) {
              final date =
                  '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
              final time =
                  '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
              print('- $date at $time with ${appointment.patient.name}');
            }
          }
          break;
        case '3':
          final completableAppointments = doctor.appointments
              .where((appointment) =>
                  appointment.status == AppointmentStatus.scheduled &&
                  appointment.endTime.isBefore(DateTime.now()))
              .toList();

          if (completableAppointments.isEmpty) {
            print('No appointments to mark as completed.');
            break;
          }

          print('\nAppointments to complete:');
          for (int i = 0; i < completableAppointments.length; i++) {
            final appointment = completableAppointments[i];
            //ai-generated
            final date =
                '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
            final time =
                '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
            print('${i + 1}. $date at $time with ${appointment.patient.name}');
          }

          stdout.write('Enter appointment number to mark as completed: ');
          final String input = stdin.readLineSync() ?? '';

          try {
            int index = int.parse(input);
            if (index < 1 || index > completableAppointments.length) {
              print('Invalid selection.');
            } else {
              final appointment = completableAppointments[index - 1];
              appointment.markCompleted();
              print('Appointment marked as completed.');
            }
          } catch (e) {
            print('Please enter a valid number.');
          }
          break;
        case '4':
          if (doctor.appointments.isEmpty) {
            print('No appointments to view patient details.');
            break;
          }

          print('\nYour appointments:');
          for (int i = 0; i < doctor.appointments.length; i++) {
            final appointment = doctor.appointments[i];
            //ai-generated
            final date =
                '${appointment.startTime.day.toString().padLeft(2, '0')}/${appointment.startTime.month.toString().padLeft(2, '0')}/${appointment.startTime.year}';
            final time =
                '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')}';
            print('${i + 1}. $date at $time with ${appointment.patient.name}');
          }

          stdout.write('Enter appointment number to view patient details: ');
          final String input = stdin.readLineSync() ?? '';

          try {
            int index = int.parse(input);
            if (index < 1 || index > doctor.appointments.length) {
              print('Invalid selection.');
            } else {
              final appointment = doctor.appointments[index - 1];
              final patient = appointment.patient;
              print('\n--- Patient Details ---');
              print('Name: ${patient.name}');
              print('Age: ${patient.age}');
              print('Gender: ${patient.gender.name}');
              print('Email: ${patient.email}');
              print('Description: ${patient.description ?? 'N/A'}');
              print('----------------------');
            }
          } catch (e) {
            print('Please enter a valid number.');
          }
          break;
        case '5':
          print('Exiting....');
          return;
      }
    }
  }
}
