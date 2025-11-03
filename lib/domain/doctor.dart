import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/availability.dart';
import 'package:my_first_project/domain/appointmentManager.dart';
import 'package:uuid/uuid.dart';

enum Gender { Male, Female }

enum Specialization {
  generalPractitioner,
  pediatrician,
  cardiologist,
  dermatologist,
  neurologist,
  orthopedist,
  gynecologist,
  psychiatrist,
  surgeon
}

class Doctor {
  String _id;
  String _name;
  String _password;
  Specialization _specialization;
  String _email;
  List<Availability> availability = [];
  List<Appointment> appointments = [];

  static final _uuid = Uuid();

  String get id => _id;
  String get password => _password;
  String get name => _name;
  Specialization get specialization => _specialization;
  String get email => _email;

  Doctor(
      {String? id,
      required String name,
      required String password,
      required Specialization specialization,
      required String email,
      List<Availability>? availibility})
      : _id = id ?? _uuid.v4(),
        _name = name,
        _password = password,
        _specialization = specialization,
        _email = email,
        availability = availibility ?? [];

  bool isAvaialable(DateTime start, DateTime end, Appointmentmanager manager) {
    final bool fitSlots = availability.any((slot) => slot.isFits(start, end));

    if (!fitSlots) return false;

    final bool hasConflict = manager.getAllAppointmentForDoctor(this).any((a) =>
        a.conflictsWith(Appointment(
            doctor: this, patient: a.patient, startTime: start, endTime: end)));

    return !hasConflict;
  }

  @override
  String toString() {
    return '''
      Doctor ID: $_id
      Name: $_name
      Specialization: ${_specialization.name}
      Email: $_email
      Availability: $availability
      Appointment: $appointments
    ''';
  }
}
