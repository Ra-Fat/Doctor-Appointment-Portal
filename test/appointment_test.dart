import 'package:test/test.dart';
import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'test_data.dart';

void main() {
  group('Appointment Tests', () {
    late Doctor doctor;
    late Patient patient;
    late Appointment appointment;

    setUp(() {
      doctor = TestData.doctor1;
      patient = TestData.patient1;

      final tomorrow = DateTime.now().add(Duration(days: 1));
      appointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: tomorrow,
        endTime: tomorrow.add(Duration(hours: 1)),
      );
    });

    test('Appointment should be created with scheduled status by default', () {
      expect(appointment.status, equals(AppointmentStatus.scheduled));
    });

    test('Appointment should have unique ID', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final appointment2 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: tomorrow,
        endTime: tomorrow.add(Duration(hours: 1)),
      );

      expect(appointment.id, isNotEmpty);
      expect(appointment.id, isNot(equals(appointment2.id)));
    });

    test('Appointment should be upcoming if start time is in future', () {
      expect(appointment.isUpcoming(), isTrue);
    });

    test('Appointment should not be upcoming if start time is in past', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      final pastAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: yesterday,
        endTime: yesterday.add(Duration(hours: 1)),
      );

      expect(pastAppointment.isUpcoming(), isFalse);
    });

    test('Appointment should be marked as completed', () {
      appointment.markCompleted();
      expect(appointment.status, equals(AppointmentStatus.completed));
    });

    test('Appointment should be marked as cancelled', () {
      appointment.markCancelled();
      expect(appointment.status, equals(AppointmentStatus.cancelled));
    });

    test('Appointment should detect missed status', () {
      // Create appointment that ended 25 hours ago (beyond grace period)
      final longAgo = DateTime.now().subtract(Duration(hours: 25));
      final missedAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: longAgo.subtract(Duration(hours: 1)),
        endTime: longAgo,
        status: AppointmentStatus.scheduled,
      );

      expect(missedAppointment.isMissed(), isTrue);
    });

    test('Completed appointment should not be considered missed', () {
      final yesterday = DateTime.now().subtract(Duration(days: 2));
      final completedAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: yesterday,
        endTime: yesterday.add(Duration(hours: 1)),
        status: AppointmentStatus.completed,
      );

      expect(completedAppointment.isMissed(), isFalse);
    });

    test('Cancelled appointment should not be considered missed', () {
      final yesterday = DateTime.now().subtract(Duration(days: 2));
      final cancelledAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: yesterday,
        endTime: yesterday.add(Duration(hours: 1)),
        status: AppointmentStatus.cancelled,
      );

      expect(cancelledAppointment.isMissed(), isFalse);
    });

    test('Appointment should check if cancelled', () {
      expect(appointment.isCancelled(), isFalse);
      appointment.markCancelled();
      expect(appointment.isCancelled(), isTrue);
    });

    test('Appointment should be reschedulable if scheduled and upcoming', () {
      expect(appointment.canBeRescheduled(), isTrue);
    });

    test('Completed appointment cannot be rescheduled', () {
      appointment.markCompleted();
      expect(appointment.canBeRescheduled(), isFalse);
    });

    test('Cancelled appointment cannot be rescheduled', () {
      appointment.markCancelled();
      expect(appointment.canBeRescheduled(), isFalse);
    });

    test('Past appointment cannot be rescheduled', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      final pastAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: yesterday,
        endTime: yesterday.add(Duration(hours: 1)),
      );

      expect(pastAppointment.canBeRescheduled(), isFalse);
    });

    test('Appointments should detect time conflicts', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start1 =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end1 = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0);

      final appointment1 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start1,
        endTime: end1,
      );

      // Overlapping appointment
      final start2 =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 30);
      final end2 =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 30);

      final appointment2 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start2,
        endTime: end2,
      );

      expect(appointment1.conflictsWith(appointment2), isTrue);
    });

    test('Non-overlapping appointments should not conflict', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start1 =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end1 = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0);

      final appointment1 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start1,
        endTime: end1,
      );

      // Non-overlapping appointment
      final start2 =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0);
      final end2 = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 12, 0);

      final appointment2 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start2,
        endTime: end2,
      );

      expect(appointment1.conflictsWith(appointment2), isFalse);
    });

    test('Appointments with different doctors should not conflict', () {
      final doctor2 = TestData.doctor2;

      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0);

      final appointment2 = Appointment(
        doctor: doctor2,
        patient: patient,
        startTime: start,
        endTime: end,
      );

      expect(appointment.conflictsWith(appointment2), isFalse);
    });

    test('Appointment toString should contain relevant information', () {
      final str = appointment.toString();
      expect(str, contains('Appointment ID'));
      expect(str, contains('Start Time'));
      expect(str, contains('End Time'));
      expect(str, contains('Status'));
    });
  });
}
