import 'dart:io';
import '../domain/appointment.dart';
import '../domain/users/doctor.dart';
import 'invoice.dart';
import '../domain/hospitalSystem.dart';
import '../domain/users/patient.dart';

class MenuConsole{
  // late Hospitalsystem hospitalsystem;

  void Menu(){

    print("--- Welcome to CADT hospital ---");

    while(true){
      print('---------------------------');
      print("1. Manage Appointment");
      print("2. Manage Patient");
      print("3. Arrange Doctor");
      print("4. Exit the program");
      print('---------------------------');

      stdout.write("Enter your choice: ");
      String? choice= stdin.readLineSync();

      switch(choice){
        case "1":
          break;
        case "2":
          break;
        case "3":
          break;
        case "4":
          print("Exit the program!!!");
          return;
        default:
          print("Invalid choice !!! \n");
      }
    }
  }
}
