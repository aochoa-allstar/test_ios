import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/company_man_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';

class UpdateProjectController extends GetxController {
  final CustomersRepository customersRepository = Get.find();
  final CompanyMenRepository companyMenRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();

  //final submitButton = RoundedLoadingButtonController();

  final customers = List<Customer>.empty(growable: true).obs;
  final selectedCustomer = Rxn<int>();

  final companyMen = List<CompanyMan>.empty(growable: true).obs;
  final filtredCompanyMan = List<CompanyMan>.empty(growable: true).obs;
  final userLocation = UserCoordinates(latitude: null, longitude: null).obs;

  final createProjectFormBuilderKey = GlobalKey<FormBuilderState>().obs;
  final project = Rxn<Project>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    Get.arguments != null ? project.value = Get.arguments : null;

    //patch values to the form if project is not null
    if (project.value != null) {
      createProjectFormBuilderKey.value.currentState?.patchValue({
        "name": project.value?.name,
        "initial_date": project.value?.initialDate,
        "estimated_completion": project.value?.estimatedCompletion,
        "cost": project.value?.cost,
        "latitude": project.value?.latitude,
        "longitude": project.value?.longitude,
        "po_afe": project.value?.poAfe,
        "table_income_tax_state_id": project.value?.tableIncomeTaxStateId,
        "project_type": project.value?.projectType,
      });
    }

    customers.addAll(await customersRepository
        .getCustomers()
        .then((ApiResponse response) => response.data));
    companyMen.addAll(await companyMenRepository
        .getAllCompanyMen()
        .then((ApiResponse response) => response.data));

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

//TODO: Implement UpdateProjectController
  Future<void> getUserLocation() async {
    final location = await projectsRepository.getLocation();
    userLocation.value = location;
  }

  void handleSelectedCustomerChange(Object? value) {
    final selectedCustomerId = value as int;
    selectedCustomer.value = selectedCustomerId;
    filtredCompanyMan.value = companyMen.where((companyMan) {
      return companyMan.customerId == selectedCustomerId;
    }).toList();
  }
}
