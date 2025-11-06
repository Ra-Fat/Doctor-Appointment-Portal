import 'package:test/test.dart';
import 'package:my_first_project/service/appointment_manager.dart';
import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'test_data.dart';

void main() {
  group('Appointment Scheduling Tests', () {
    late Appointmentmanager manager;
    late Doctor doctor;
    late Patient patient;

    setUp(() {
      manager = Appointmentmanager(appointments: []);
      doctor = TestData.doctor1;
      patient = TestData.patient1;
      // Clear appointments from previous tests
      doctor.appointments = [];
      patient.appointments = [];
    });

    test('Should successfully schedule appointment with valid data', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      final result = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Regular checkup',
      );

      expect(result, isTrue);
      expect(manager.appointments.length, equals(1));
      expect(doctor.appointments.length, equals(1));
      expect(patient.appointments.length, equals(1));
      expect(manager.appointments.first.description, equals('Regular checkup'));
    });

    test('Should fail to schedule appointment in the past', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      final start =
          DateTime(yesterday.year, yesterday.month, yesterday.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      final result = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: null,
      );

      expect(result, isFalse);
      expect(manager.appointments, isEmpty);
    });

    test('Should fail to schedule appointment with less than 1 hour notice',
        () {
      final now = DateTime.now();
      final start = now.add(Duration(minutes: 30));
      final end = start.add(Duration(hours: 1));

      final result = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Urgent',
      );

      expect(result, isFalse);
      expect(manager.appointments, isEmpty);
    });

    test('Should fail to schedule if start time is after end time', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 0);
      final end = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);

      final result = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Wrong timing',
      );

      expect(result, isFalse);
      expect(manager.appointments, isEmpty);
    });

    test('Should detect patient conflict when scheduling', () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      // Schedule first appointment
      final result1 = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Initial appointment',
      );
      expect(result1, isTrue);

      // Try to schedule overlapping appointment for same patient with different doctor
      final overlappingStart = start.add(Duration(minutes: 30));
      final overlappingEnd = overlappingStart.add(Duration(hours: 1));

      final result2 = manager.scheduleAppointment(
        patient,
        TestData.doctor2,
        overlappingStart,
        overlappingEnd,
        description: 'Overlap test',
      );

      expect(result2, isFalse);
      expect(manager.appointments.length, equals(1));
    });

    test('Should allow scheduling different patients with different doctors',
        () {
      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      final patient2 = TestData.patient2;
      final doctor2 = TestData.doctor2;
      patient2.appointments = [];
      doctor2.appointments = [];

      final result1 = manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Patient 1 appointment',
      );
      final result2 = manager.scheduleAppointment(
        patient2,
        doctor2,
        start,
        end,
        description: 'Patient 2 appointment',
      );

      expect(result1, isTrue);
      expect(result2, isTrue);
      expect(manager.appointments.length, equals(2));
    });
  });

  group('Appointment Cancellation Tests', () {
    late Appointmentmanager manager;
    late Doctor doctor;
    late Patient patient;
    late Appointment appointment;

    setUp(() {
      manager = Appointmentmanager(appointments: []);
      doctor = TestData.doctor1;
      patient = TestData.patient1;
      doctor.appointments = [];
      patient.appointments = [];

      // Schedule an appointment
      final tomorrow = DateTime.now().add(Duration(days: 2));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Cancellation test',
      );
      appointment = manager.appointments.first;
    });

    test('Should successfully cancel appointment', () {
      expect(appointment.status, equals(AppointmentStatus.scheduled));

      final result = manager.cancelAppointment(appointment);

      expect(result, isTrue);
      expect(appointment.status, equals(AppointmentStatus.cancelled));

      // The appointment remains in the list after cancellation:
      expect(manager.appointments.length, equals(1));
      expect(doctor.appointments.length, equals(1));
      expect(patient.appointments.length, equals(1));
    });

    test('Should fail to cancel non-existent appointment', () {
      final fakeAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
      );

      final result = manager.cancelAppointment(fakeAppointment);

      expect(result, isFalse);
      expect(manager.appointments.length, equals(1));
    });

    test('Should fail to cancel already cancelled appointment', () {
      manager.cancelAppointment(appointment);

      // Try to cancel again
      final result = manager.cancelAppointment(appointment);

      expect(result, isFalse);
    });

    test('Should fail to cancel completed appointment', () {
      appointment.markCompleted();

      final result = manager.cancelAppointment(appointment);

      expect(result, isFalse);
    });
  });

  group('Appointment Rescheduling Tests', () {
    late Appointmentmanager manager;
    late Doctor doctor;
    late Patient patient;
    late Appointment appointment;

    setUp(() {
      manager = Appointmentmanager(appointments: []);
      doctor = TestData.doctor1;
      patient = TestData.patient1;
      doctor.appointments = [];
      patient.appointments = [];

      final tomorrow = DateTime.now().add(Duration(days: 2));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      manager.scheduleAppointment(
        patient,
        doctor,
        start,
        end,
        description: 'Reschedule test',
      );
      appointment = manager.appointments.first;
    });

    test('Should successfully reschedule appointment', () {
      final newDate = DateTime.now().add(Duration(days: 3));
      final newStart =
          DateTime(newDate.year, newDate.month, newDate.day, 14, 0);
      final newEnd = newStart.add(Duration(hours: 1));

      final result =
          manager.rescheduleAppointment(appointment, newStart, newEnd);

      expect(result, isTrue);
      expect(appointment.startTime, equals(newStart));
      expect(appointment.endTime, equals(newEnd));
    });

    test('Should fail to reschedule non-existent appointment', () {
      final fakeAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
      );

      final newDate = DateTime.now().add(Duration(days: 3));
      final newStart =
          DateTime(newDate.year, newDate.month, newDate.day, 14, 0);
      final newEnd = newStart.add(Duration(hours: 1));

      final result =
          manager.rescheduleAppointment(fakeAppointment, newStart, newEnd);

      expect(result, isFalse);
    });

    test('Should fail to reschedule cancelled appointment', () {
      appointment.markCancelled();

      final newDate = DateTime.now().add(Duration(days: 3));
      final newStart =
          DateTime(newDate.year, newDate.month, newDate.day, 14, 0);
      final newEnd = newStart.add(Duration(hours: 1));

      final result =
          manager.rescheduleAppointment(appointment, newStart, newEnd);

      expect(result, isFalse);
    });

    test('Should fail to reschedule to past time', () {
      final yesterday = DateTime.now().subtract(Duration(days: 1));
      final newStart =
          DateTime(yesterday.year, yesterday.month, yesterday.day, 10, 0);
      final newEnd = newStart.add(Duration(hours: 1));

      final result =
          manager.rescheduleAppointment(appointment, newStart, newEnd);

      expect(result, isFalse);
    });

    test('Should fail to reschedule to time with less than 1 hour notice', () {
      final now = DateTime.now();
      final newStart = now.add(Duration(minutes: 30));
      final newEnd = newStart.add(Duration(hours: 1));

      final result =
          manager.rescheduleAppointment(appointment, newStart, newEnd);

      expect(result, isFalse);
    });
  });

  group('Missed Appointment Tests', () {
    late Appointmentmanager manager;
    late Doctor doctor;
    late Patient patient;

    setUp(() {
      manager = Appointmentmanager(appointments: []);
      doctor = TestData.doctor1;
      patient = TestData.patient1;
      doctor.appointments = [];
      patient.appointments = [];
    });

    test('Should mark appointment as missed after grace period', () {
      // Create appointment that ended 25 hours ago (beyond 24-hour grace period)
      final longAgo = DateTime.now().subtract(Duration(hours: 25));
      final start = longAgo.subtract(Duration(hours: 1));
      final end = longAgo;

      final missedAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start,
        endTime: end,
        status: AppointmentStatus.scheduled,
      );

      manager.appointments.add(missedAppointment);
      manager.updateMissedAppointment();

      expect(missedAppointment.status, equals(AppointmentStatus.missed));
    });

    test('Should not mark appointment as missed within grace period', () {
      // Create appointment that ended 20 hours ago (within 24-hour grace)
      final recentlyEnded = DateTime.now().subtract(Duration(hours: 20));
      final start = recentlyEnded.subtract(Duration(hours: 1));
      final end = recentlyEnded;

      final recentAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start,
        endTime: end,
        status: AppointmentStatus.scheduled,
      );

      manager.appointments.add(recentAppointment);
      manager.updateMissedAppointment();

      expect(recentAppointment.status, equals(AppointmentStatus.scheduled));
    });

    test('Should not mark completed appointments as missed', () {
      final longAgo = DateTime.now().subtract(Duration(hours: 25));
      final start = longAgo.subtract(Duration(hours: 1));
      final end = longAgo;

      final completedAppointment = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: start,
        endTime: end,
        status: AppointmentStatus.completed,
      );

      manager.appointments.add(completedAppointment);
      manager.updateMissedAppointment();

      expect(completedAppointment.status, equals(AppointmentStatus.completed));
    });

    test('Should update multiple missed appointments at once', () {
      final longAgo = DateTime.now().subtract(Duration(hours: 25));

      final appointment1 = Appointment(
        doctor: doctor,
        patient: patient,
        startTime: longAgo.subtract(Duration(hours: 1)),
        endTime: longAgo,
      );

      final doctor2 = TestData.doctor2;
      final patient2 = TestData.patient2;
      doctor2.appointments = [];
      patient2.appointments = [];

      final appointment2 = Appointment(
        doctor: doctor2,
        patient: patient2,
        startTime: longAgo.subtract(Duration(hours: 1)),
        endTime: longAgo,
      );

      manager.appointments.addAll([appointment1, appointment2]);
      manager.updateMissedAppointment();

      expect(appointment1.status, equals(AppointmentStatus.missed));
      expect(appointment2.status, equals(AppointmentStatus.missed));
    });
  });

  group('Get Available Doctors Tests', () {
    late Appointmentmanager manager;

    setUp(() {
      manager = Appointmentmanager(appointments: []);
    });

    test('Should return all doctors when none have conflicts', () {
      final doctors = [TestData.doctor1, TestData.doctor2, TestData.doctor3];
      for (var doc in doctors) {
        doc.appointments = [];
      }

      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      final available = manager.getAvailableDoctors(start, end, doctors);

      expect(available.length, equals(3));
    });

    test('Should exclude doctor with conflicting appointment', () {
      final doctor1 = TestData.doctor1;
      final doctor2 = TestData.doctor2;
      doctor1.appointments = [];
      doctor2.appointments = [];

      final patient = TestData.patient1;
      patient.appointments = [];

      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      // Schedule appointment with doctor1
      manager.scheduleAppointment(
        patient,
        doctor1,
        start,
        end,
        description: 'Conflicting appointment',
      );

      // Check availability for both doctors
      final doctors = [doctor1, doctor2];
      final available = manager.getAvailableDoctors(start, end, doctors);

      expect(available.length, equals(1));
      expect(available.first.id, equals(doctor2.id));
    });

    test('Should return empty list when all doctors are busy', () {
      final doctor1 = TestData.doctor1;
      final doctor2 = TestData.doctor2;
      doctor1.appointments = [];
      doctor2.appointments = [];

      final patient1 = TestData.patient1;
      final patient2 = TestData.patient2;
      patient1.appointments = [];
      patient2.appointments = [];

      final tomorrow = DateTime.now().add(Duration(days: 1));
      final start =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 0);
      final end = start.add(Duration(hours: 1));

      // Schedule both doctors
      manager.scheduleAppointment(
        patient1,
        doctor1,
        start,
        end,
        description: 'Busy doctor 1',
      );
      manager.scheduleAppointment(
        patient2,
        doctor2,
        start,
        end,
        description: 'Busy doctor 2',
      );

      final doctors = [doctor1, doctor2];
      final available = manager.getAvailableDoctors(start, end, doctors);

      expect(available, isEmpty);
    });
  });
}
