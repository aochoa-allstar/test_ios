import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/account/bindings/account_binding.dart';
import 'package:onax_app/app/modules/account/views/account_view.dart';
import 'package:onax_app/app/modules/auth/bindings/recover_password_binding.dart';
import 'package:onax_app/app/modules/driverLocations/bindings/create_driver_locations_binding.dart';
import 'package:onax_app/app/modules/home/bindings/home_binding.dart';
import 'package:onax_app/app/modules/jsa/bindings/create_jsa_binding.dart';
import 'package:onax_app/app/modules/jsa/bindings/jsa_details_binding.dart';
import 'package:onax_app/app/modules/jsa/bindings/list_jsas_binding.dart';
import 'package:onax_app/app/modules/jsa/views/create_jsa_view.dart';
import 'package:onax_app/app/modules/jsa/views/jsa_details_view.dart';
import 'package:onax_app/app/modules/jsa/views/list_jsas_view.dart';
import 'package:onax_app/app/modules/project/bindings/create_project_controller.dart';
import 'package:onax_app/app/modules/project/bindings/list_projects_binding.dart';
import 'package:onax_app/app/modules/project/bindings/update_project_controller.dart';
import 'package:onax_app/app/modules/project/views/create_project_view.dart';
import 'package:onax_app/app/modules/project/views/list_projects_view.dart';
import 'package:onax_app/app/modules/project/views/update_project_view.dart';
import 'package:onax_app/app/modules/shift/bindings/create_shift_binding.dart';
import 'package:onax_app/app/modules/shift/views/create_shift_view.dart';
import 'package:onax_app/app/modules/tabs/tabs_binding.dart';
import 'package:onax_app/app/modules/tabs/tabs_view.dart';
import 'package:onax_app/app/modules/ticket/bindings/create_ticket_binding.dart';
import 'package:onax_app/app/modules/ticket/bindings/list_tickets_binding.dart';
import 'package:onax_app/app/modules/ticket/bindings/ticket_details_binding.dart';
import 'package:onax_app/app/modules/ticket/bindings/update_ticket_binding.dart';
import 'package:onax_app/app/modules/ticket/views/create_ticket_view.dart';
import 'package:onax_app/app/modules/ticket/views/list_tickets_view.dart';
import 'package:onax_app/app/modules/ticket/views/ticket_details_view.dart';
import 'package:onax_app/app/modules/ticket/views/update_ticket_view.dart';
import 'package:onax_app/core/middlewares/auth_guard.dart';

import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/recover_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Main page/ Initial route
  static const INITIAL = Routes.TABS;

  static final routes = [
    // Authentication
    GetPage(
      name: _Paths.AUTH,
      page: () => Text('404'),
      children: [
        GetPage(
          name: _Paths.LOGIN,
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: _Paths.FORGOT_PASSWORD,
          page: () => const RecoverPasswordView(),
          binding: RecoverPasswordBinding(),
        ),
      ],
    ),

    GetPage(
      name: _Paths.TABS,
      page: () => Tabs(),
      bindings: [
        TabsBinding(),
        HomeBinding(),
        ListJSAsBinding(),
        ListProjectsBinding(),
        AccountBinding(),
        CreateDriverLocationBinding()
      ],
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: _Paths.TICKET,
      page: () => ListTicketsView(),
      binding: ListTicketsBinding(),
      children: [
        GetPage(
          name: _Paths.CREATE,
          page: () => CreateTicketView(),
          binding: CreateTicketBinding(),
        ),
        GetPage(
          name: _Paths.UPDATE,
          page: () => UpdateTicketView(),
          binding: UpdateTicketBinding(),
        ),
        GetPage(
          name: _Paths.VIEW,
          page: () => TicketDetailsView(),
          binding: TicketDetailsBinding(),
        ),
      ],
    ),

    GetPage(
      name: _Paths.SHIFT,
      page: () => Text('404'),
      children: [
        GetPage(
          name: _Paths.CREATE,
          page: () => CreateShiftView(),
          binding: CreateShiftBinding(),
        ),
      ],
    ),

    GetPage(
      name: _Paths.PROJECT,
      page: () => ListProjectsView(),
      binding: ListProjectsBinding(),
      children: [
        GetPage(
          name: _Paths.CREATE,
          page: () => CreateProjectView(),
          binding: CreateProjectBinding(),
        ),
        GetPage(
          name: _Paths.UPDATE,
          page: () => UpdateProjectView(),
          binding: UpdateProjectBinding(),
        )
      ],
    ),

    GetPage(
      name: _Paths.JSA,
      page: () => ListJSAsView(),
      binding: ListJSAsBinding(),
      children: [
        GetPage(
          name: _Paths.CREATE,
          page: () => CreateJSAView(),
          binding: CreateJSABinding(),
        ),
        GetPage(
          name: _Paths.UPDATE,
          page: () => Text('Update JSA'),
        ),
        GetPage(
          name: _Paths.VIEW,
          page: () => JSADetailsView(),
          binding: JSADetailsBinding(),
        ),
      ],
    ),

    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    // GetPage(name: Routes.LEGACY_START, page: () => SplashScreen()),
    // GetPage(name: Routes.LEGACY_LOGIN, page: () => LoginScreen()),
    // GetPage(name: Routes.LEGACY_PAGES, page: () => PagesScreen()),
    // GetPage(name: Routes.LEGACY_HOME, page: () => HomeScreen()),
    // GetPage(name: Routes.LEGACY_SECOND, page: () => JsasFormScreen()),
    // GetPage(name: Routes.LEGACY_NEW_TICKET, page: () => CreateTicketForm()),
    // GetPage(
    //     name: Routes.LEGACY_BLOCK_SCREEN,
    //     page: () => PermissionsNotGrantedPage()),
    // GetPage(
    //     name: Routes.LEGACY_NEW_SHIFT, page: () => CreateNewShiftFormScrenn()),
    // GetPage(
    //     name: Routes.LEGACY_TICKET_TO_SIGNATURE,
    //     page: () => TicketsToSignature()),
    // GetPage(
    //     name: Routes.LEGACY_ADD_DESTINATION,
    //     page: () => AddDestinationScreen()),
    // GetPage(name: Routes.LEGACY_ADD_PROJECT, page: () => AddProjects()),
    // GetPage(name: Routes.LEGACY_LIST_JSAS, page: () => JsasToSignature()),
  ];
}
