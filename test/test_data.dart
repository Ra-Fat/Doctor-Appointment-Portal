import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:my_first_project/domain/users/user.dart';
import 'package:my_first_project/domain/availability.dart';

class TestData {
  // Mock Doctors with 24/7 availability for testing
  static Doctor get doctor1 {
    final doc = Doctor(
      id: 'd1',
      email: 'doctor1@test.com',
      password: 'password123',
      name: 'Dr. Sarah Smith',
      age: 21,
      gender: Gender.Female,
      specialization: Specialization.cardiologist,
    );
    // Add availability for all days, all hours
    doc.availability = _getAllDayAvailability();
    return doc;
  }

  static Doctor get doctor2 {
    final doc = Doctor(
      id: 'd2',
      email: 'doctor2@test.com',
      password: 'password123',
      name: 'Dr. John Jones',
      age: 20,
      gender: Gender.Male,
      specialization: Specialization.pediatrician,
    );
    doc.availability = _getAllDayAvailability();
    return doc;
  }

  static Doctor get doctor3 {
    final doc = Doctor(
      id: 'd3',
      email: 'doctor3@test.com',
      password: 'password123',
      name: 'Dr. Emily Brown',
      age: 30,
      gender: Gender.Female,
      specialization: Specialization.generalPractitioner,
    );
    doc.availability = _getAllDayAvailability();
    return doc;
  }

  static List<Availability> _getAllDayAvailability() {
    return [
      Availability(
        day: 'Monday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Tuesday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Wednesday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Thursday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Friday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Saturday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
      Availability(
        day: 'Sunday',
        startTime: DateTime(2000, 1, 1, 0, 0),
        endTime: DateTime(2000, 1, 1, 23, 59),
      ),
    ];
  }

  // Mock Patients
  static Patient get patient1 => Patient(
        id: 'p1',
        email: 'patient1@test.com',
        password: 'password123',
        gender: Gender.Male,
        name: 'John Doe',
        age: 30,
        description: 'Regular checkup patient',
      );

  static Patient get patient2 => Patient(
        id: 'p2',
        email: 'patient2@test.com',
        password: 'password123',
        gender: Gender.Female,
        name: 'Jane Smith',
        age: 25,
        description: 'Follow-up patient',
      );

  static Patient get patient3 => Patient(
        id: 'p3',
        email: 'patient3@test.com',
        password: 'password123',
        gender: Gender.Female,
        name: 'Alice Johnson',
        age: 45,
        description: 'New patient',
      );
}
