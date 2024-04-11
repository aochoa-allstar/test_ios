import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/jsa/widgets/jsa_list_item.dart';

import '../controllers/list_jsas_controller.dart';

class ListJSAsView extends GetView<ListJSAsController> {
  ListJSAsView({Key? key}) : super(key: key);

  final ListJSAsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
            onRefresh: () async => await controller.fetchJSAs(),
            child: controller.jsas.value.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return JSAListItem(
                        jsa: controller.jsas.value[index],
                        index: index,
                        length: controller.jsas.value.length,
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemCount: controller.jsas.value.length,
                  )
                : Center(
                    child: Text('jsas_noJSAs'.tr,
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  )),
      ),
    );
  }
}
