import 'package:my_first_project/data/user_repository.dart';
import 'package:my_first_project/service/user_service.dart';
import 'package:my_first_project/service/appointment_manager.dart';
import 'package:my_first_project/domain/users/doctor.dart';
import 'package:my_first_project/domain/users/patient.dart';
import 'package:my_first_project/ui/menu.dart';
import 'package:my_first_project/domain/users/user.dart';
import './data/appointment_data.dart';

void main() async {

  final repo = UserRepository(
    userFilePath: 'lib/data/json/user.json',
    patientFilePath: 'lib/data/json/patients.json',
    doctorFilePath: 'lib/data/json/doctors.json',
  );

  List<User> allUsers = await loadAndMergeUsers(repo);

  List<Patient> patients = allUsers.whereType<Patient>().toList();
  List<Doctor> doctors = allUsers.whereType<Doctor>().toList();

  final appointmentRepo = AppointmentRepository('lib/data/json/appointments.json');

  // load all existing appointments
  final appointments = await appointmentRepo.loadAppointments(doctors, patients);

  // created AppointmentManager
  final manager = Appointmentmanager(appointments: appointments);

  MenuConsole menuConsole = MenuConsole(manager, patients, doctors, appointmentRepo);
  await menuConsole.start();

  await appointmentRepo.saveAppointments(manager.appointments);

  print('All appointments saved successfully!');
}
