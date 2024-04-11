import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/company_man_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/user_coordinates_model.dart';
import 'package:onax_app/app/data/repositories/company_men_repository.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/projects_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateProjectController extends GetxController {
  final CustomersRepository customersRepository = Get.find();
  final CompanyMenRepository companyMenRepository = Get.find();
  final ProjectsRepository projectsRepository = Get.find();

  final submitButton = RoundedLoadingButtonController();

  final customers = List<Customer>.empty(growable: true).obs;
  final selectedCustomer = Rxn<int>();

  final companyMen = List<CompanyMan>.empty(growable: true).obs;
  final filtredCompanyMan = List<CompanyMan>.empty(growable: true).obs;
  final userLocation = UserCoordinates(latitude: null, longitude: null).obs;

  final createProjectFormBuilderKey = GlobalKey<FormBuilderState>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    getCustomers();
    companyMen.addAll(await companyMenRepository
        .getAllCompanyMen()
        .then((ApiResponse response) => response.data));
    getUserLocation();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserLocation() async {
    final location = await projectsRepository.getLocation();
    userLocation.value = location;
  }

  void getCustomers() async {
    final response = await customersRepository.getCustomers();
    if (response.success == true) {
      customers.addAll(response.data!);
    }
  }

  Future<void> createProject() async {
    //Validate form
    if (!createProjectFormBuilderKey.value.currentState!.saveAndValidate()) {
      submitButton.reset();
      return;
    }

    //Get form data values
    final shiftData =
        Map.from(createProjectFormBuilderKey.value.currentState!.value);

    final response = await projectsRepository.createProject(
      shiftData['customer_id'],
      shiftData['name'],
      shiftData['coords'],
      shiftData['company_men_id'],
    );

    if (response.success == true) {
      submitButton.success();
      Get.offAllNamed(Routes.TABS);
    } else {
      submitButton.error();
      submitButton.reset();
    }
  }

  void handleSelectedCustomerChange(Object? value) {
    final selectedCustomerId = value as int;
    selectedCustomer.value = selectedCustomerId;

    //Clear the selected company men id
    if (createProjectFormBuilderKey
            .value.currentState?.fields["company_men_id"] !=
        null) {
      createProjectFormBuilderKey.value.currentState?.patchValue({
        "company_men_id": null,
      });
    }

    filtredCompanyMan.value = companyMen.where((companyMan) {
      return companyMan.customerId == selectedCustomerId;
    }).toList();
  }
}
