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
  Specialization _specialization;
  String _email;
  List<Availability> availability;

  static final _uuid = Uuid();

  String get id => _id;
  String get name => _name;
  Specialization get specialization => _specialization;
  String get email => _email;

  Doctor(
      {String? id,
      required String name,
      required Specialization specialization,
      required String email,
      List<Availability>? availibility})
      : _id = id ?? _uuid.v4(),
        _name = name,
        _specialization = specialization,
        _email = email,
        availability = availibility ?? [];

  bool isAvaialble(DateTime start, DateTime end, Appointmentmanager manager) {
    List<Appointment> appointments = manager.getAllAppointment(this);

    String dayName = getDayName(start.weekday);
    bool validSlot = availability.any((slot) =>
        slot.day == dayName &&
        start.isAfter(slot.startTime) &&
        end.isBefore(slot.endTime));

    if (!validSlot) return false;

    bool hasConflict = appointments.any((a) =>
        a.status == AppointmentStatus.scheduled &&
        start.isBefore(a.endTime) &&
        end.isAfter(a.startTime));

    if (hasConflict) return false;

    return true;
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return '''
      Doctor ID: $_id
      Name: $_name
      Specialization: ${_specialization.name}
      Email: $_email
      Availability: $availability
    ''';
  }
}
