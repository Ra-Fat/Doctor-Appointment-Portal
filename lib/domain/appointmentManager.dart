import 'package:my_first_project/domain/appointment.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';

class Appointmentmanager {
  List<Appointment> appointments;

  Appointmentmanager({required this.appointments});

  List<Appointment> getAllAppointmentForDoctor(Doctor doctor) {
    return appointments =
        appointments.where((doctor) => doctor == doctor.id).toList();
  }

  // get all appointment from system
  List<Appointment> getAllAppointment(){
    return List<Appointment>.from(appointments);
  }

  // get all appointment for target doctor
  List<Appointment> getDoctorAppointment(Doctor doctor) {
    return appointments.where((appointment)=> appointment.doctor.id == doctor.id).toList();
  }

  List<Appointment> getAllAppointmentForPatient(Patient patient) {
    return appointments =
        appointments.where((patient) => patient == patient.id).toList();
  }

  // Schedule a new appointment if no conflicts exist
  bool scheduleAppointment(
      Patient patient, Doctor doctor, DateTime start, DateTime end) {
    if (!doctor.isAvaialable(start, end, this)) {
      print('Dr.${doctor.name} is not available.');
      return false;
    }

    Appointment appointment = Appointment(
        doctor: doctor, patient: patient, startTime: start, endTime: end);

    appointments.add(appointment);
    appointment.doctor.appointments.add(appointment);
    appointment.patient.appointments.add(appointment);
    print("Appointment scheduled for ${patient.name} with Dr. ${doctor.name}");
    return true;
  }

  // Cancel an appointment
  bool cancelAppointment(Appointment appointment) {
    if (!appointments.contains(appointment)) return false;
    appointment.markCancelled();
    appointments.remove(appointment);
    appointment.doctor.appointments.remove(appointment);
    appointment.patient.appointments.remove(appointment);

    print(
        'Appointment cancelled: ${appointment.patient.name} with Dr. ${appointment.doctor.name}');
    return true;
  }

// Reschedule an existing appointment
  bool rescheduleAppointment(
      Appointment appointment, DateTime newStart, DateTime newEnd) {
    if (!appointments.contains(appointment)) return false;

    Doctor doctor = appointment.doctor;

    if (!doctor.isAvaialable(newStart, newEnd, this)) {
      print('Doctor is not available for the new time slot.');
      return false;
    }

    DateTime oldStart = appointment.startTime;
    DateTime oldEnd = appointment.endTime;

    appointment.startTime = newStart;
    appointment.endTime = newEnd;

    print("Appointment rescheduled for ${appointment.patient.name}");
    print("Old: $oldStart & $oldEnd");
    print("New: $newStart & $newEnd");

    return true;
  }

  List<Doctor> getAvailableDoctors(DateTime start, DateTime end, List<Doctor> allDoctors) {
    return allDoctors.where((doctor) => doctor.isAvaialable(start, end, this)).toList();
  }


  // /// Get all appointments for a doctor (optionally for a specific day)
  // List<Appointment> getAppointmentsForDoctor(Doctor doctor, [DateTime? day]) { ... }

  // /// Get all appointments for a patient
  // List<Appointment> getAppointmentsForPatient(Patient patient) { ... }

  // /// Check if a doctor is available for a given time
  // bool isDoctorAvailable(Doctor doctor, DateTime start, DateTime end) { ... }

  // /// Get available time slots for a doctor for a specific day
  // List<DateTimeRange> getAvailableSlots(Doctor doctor, DateTime day) { ... }

  // /// Mark appointment as completed
  // bool completeAppointment(String appointmentId) { ... }

  List<Appointment> getUpcomingAppointments(List<Appointment> appointments) {
    return appointments
        .where((appointment) => appointment.isUpcoming())
        .toList();
  }

  List<Appointment> getPastAppointments(List<Appointment> appointments) {
    return appointments.where((appointment) => appointment.isMissed()).toList();
  }
}
