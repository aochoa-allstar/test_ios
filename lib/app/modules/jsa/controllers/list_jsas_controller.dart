import 'package:get/get.dart';
import 'package:onax_app/app/data/models/api_response_model.dart';
import 'package:onax_app/app/data/models/customer_model.dart';
import 'package:onax_app/app/data/models/jsa_model.dart';
import 'package:onax_app/app/data/repositories/customers_repository.dart';
import 'package:onax_app/app/data/repositories/jsas_repository.dart';

class ListJSAsController extends GetxController {
  final JSAsRepository jsasRepository = Get.find();
  final CustomersRepository customersRepository = Get.find();

  final jsas = Rx<List<JSA>>([]);
  final customers = Rx<List<Customer>>([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchJSAs();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchJSAs() async {
    jsas.value = await jsasRepository
        .getJSAsByUser()
        .then((ApiResponse response) => response.data);
    customers.value = await customersRepository
        .getCustomers()
        .then((ApiResponse response) => response.data);
    setCustomerInformationToJSAs();
  }

  void setCustomerInformationToJSAs() {
    jsas.value.forEach((jsa) {
      jsa.customer = customers.value.firstWhere((customer) {
        return customer.id == jsa.customerId;
      }, orElse: () => Customer(name: null));
    });
    jsas.refresh();
  }
}
