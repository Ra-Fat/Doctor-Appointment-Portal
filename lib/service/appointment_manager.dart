import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';


class Appointmentmanager {
  List<Appointment> appointments;

  Appointmentmanager({required this.appointments});

  List<Appointment> getAllAppointment() {
    return List<Appointment>.from(appointments);
  }

  bool scheduleAppointment(Patient patient, Doctor doctor, DateTime start, DateTime end, {String? description}) {
    
    // validate appointment time is in the future
    if (start.isBefore(DateTime.now())) {
      print('Cannot schedule appointments in the past.');
      return false;
    }

    // validate start time is before end time
    if (!start.isBefore(end)) {
      print('Start time must be before end time.');
      return false;
    }
    
    // ai generated
    final minNotice = DateTime.now().add(Duration(hours: 1));
    if (start.isBefore(minNotice)) {
      print('Appointments must be scheduled at least 1 hour in advance.');
      return false;
    }

    if (!doctor.isAvailable(start, end)) {
      print('Dr.${doctor.name} is not available.');
      return false;
    }

    final hasPatientConflict = patient.appointments.any((existingAppointment) =>
        existingAppointment.status == AppointmentStatus.scheduled &&
        existingAppointment.startTime.isBefore(end) &&
        existingAppointment.endTime.isAfter(start));

    if (hasPatientConflict) {
      print('${patient.name} already has an appointment during this time.');
      return false;
    }

    Appointment appointment = Appointment(
      doctor: doctor,
      patient: patient,
      startTime: start,
      endTime: end,
      description: description,
    );

    appointments.add(appointment);
    doctor.appointments.add(appointment);
    patient.appointments.add(appointment);

    print("Appointment scheduled for ${patient.name} with Dr. ${doctor.name}");

    return true;
  }

  bool cancelAppointment(Appointment appointment) {
    if (!appointments.contains(appointment)) {
      print('Appointment not found.');
      return false;
    }

    if (appointment.status == AppointmentStatus.cancelled) {
      print('Appointment is already cancelled.');
      return false;
    }
    if (appointment.status == AppointmentStatus.completed) {
      print('Cannot cancel a completed appointment.');
      return false;
    }

    if (appointment.startTime.isBefore(DateTime.now())) {
      print('Cannot cancel appointments that have already started or passed.');
      return false;
    }

    appointment.markCancelled();

    print(
        'Appointment cancelled: ${appointment.patient.name} with Dr. ${appointment.doctor.name}');
    return true;
  }
  


  bool rescheduleAppointment(
      Appointment appointment, DateTime newStart, DateTime newEnd) {
    if (!appointments.contains(appointment)) {
      print('Appointment not found.');
      return false;
    }

    // Validate appointment reschedulebility
    if (!appointment.canBeRescheduled()) {
      print('This appointment cannot be rescheduled.');
      return false;
    }

    // Validate new time is in the future
    if (newStart.isBefore(DateTime.now())) {
      print('Cannot reschedule to a time in the past.');
      return false;
    }

    // Validate new start is before new end
    if (!newStart.isBefore(newEnd)) {
      print('New start time must be before new end time.');
      return false;
    }

    // Validate minimum notice period (min an hour from current time)
    final minNotice = DateTime.now().add(Duration(hours: 1));
    if (newStart.isBefore(minNotice)) {
      print('Appointments must be scheduled at least 1 hour in advance.');
      return false;
    }

    Doctor doctor = appointment.doctor;
    Patient patient = appointment.patient;

    // Check if doctor is available for new time slot
    if (!doctor.isAvailable(newStart, newEnd)) {
      print('Doctor is not available for the new time slot.');
      return false;
    }

    // Check if patient has conflicts at new time
    final hasPatientConflict = patient.appointments.any((existingAppointment) =>
        existingAppointment.id != appointment.id &&
        existingAppointment.status == AppointmentStatus.scheduled &&
        existingAppointment.startTime.isBefore(newEnd) &&
        existingAppointment.endTime.isAfter(newStart));

    if (hasPatientConflict) {
      print(
          '${patient.name} already has an appointment during the new time slot.');
      return false;
    }

    DateTime oldStart = appointment.startTime;
    DateTime oldEnd = appointment.endTime;

    appointment.startTime = newStart;
    appointment.endTime = newEnd;

    print("Appointment rescheduled for ${appointment.patient.name}");
    print("Old: $oldStart to $oldEnd");
    print("New: $newStart to $newEnd");

    return true;
  }

  List<Doctor> getAvailableDoctors(
    DateTime start, DateTime end, List<Doctor> allDoctors) {
    List<Doctor> available = [];
    for (var doctor in allDoctors) {
      if (doctor.isAvailable(start, end)) {
        available.add(doctor);
      }
    }
    return available;
  }


  void updateMissedAppointment() {
    for (Appointment appointment in appointments) {
      if (appointment.isMissed() && appointment.status == AppointmentStatus.scheduled) {
        appointment.status = AppointmentStatus.missed;
      }
    }
  }
}
