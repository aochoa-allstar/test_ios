import 'package:get/route_manager.dart';
import 'package:onax_app/src/views/addDestinationScreen.dart';
import 'package:onax_app/src/views/addProjectScreen.dart';
import 'package:onax_app/src/views/components/home/creatTicket/createTicket.dart';
import 'package:onax_app/src/views/components/home/shift/create_new_shift.dart';
import 'package:onax_app/src/views/components/login/forgotPasswordScreen.dart';
import 'package:onax_app/src/views/home_screen.dart';
import 'package:onax_app/src/views/list_jsas_screen.dart';
import 'package:onax_app/src/views/login_screen.dart';
import 'package:onax_app/src/views/permissionsNotGrantedPage.dart';
import 'package:onax_app/src/views/JsasFormScreen.dart';
import 'package:onax_app/src/views/spalsh_screen.dart';
import 'package:onax_app/src/views/ticketsToSignature.dart';

import '../views/pages_screen.dart';

getRoutes() {
  return [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/pages', page: () => PagesScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/second', page: () => JsasFormScreen()),
    GetPage(name: '/newTicket', page: () => CreateTicketForm()),
    GetPage(name: '/blockScreen', page: () => PermissionsNotGrantedPage()),
    GetPage(name: '/newShift', page: () => CreateNewShiftFormScrenn()),
    GetPage(name: '/ticketToSignature', page: () => TicketsToSignature()),
    GetPage(name: '/addDestination', page: () => AddDestinationScreen()),
    GetPage(name: '/addProject', page: () => AddProjects()),
    GetPage(name: '/listJsas', page: () => JsasToSignature()),
    //GetPage(name: '/forgotPass', page: ()=> ForgotPasswordScreen(controller: controller))
  ];
}
