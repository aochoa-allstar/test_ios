import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/project/controllers/list_projects_controller.dart';
import 'package:onax_app/app/modules/project/widgets/project_list_item.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class ListProjectsView extends GetView<ListProjectsController> {
  ListProjectsView({Key? key}) : super(key: key);

  final ListProjectsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => controller.fetchProjects(),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              CreateProjectCard(),
              ProjectsHistory(),
            ],
          )),
    );
  }

  Widget CreateProjectCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade900),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'projects_newProject'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            FilledButton(
              onPressed: () => Get.toNamed(Routes.CREATE_PROJECT),
              child: Text(
                'projects_create'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
                backgroundColor:
                    MaterialStatePropertyAll(Colors.green.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Obx ProjectsHistory() {
    return Obx(
      () => Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'projects_previousProjects'.tr,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            controller.projects.value.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Colors.grey.shade900,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: controller.projects.value
                              .asMap()
                              .entries
                              .map((e) {
                            var index = e.key;
                            var project = e.value;
                            if (index >= controller.projects.value.length)
                              return Container();
                            //if the item is not the last one, add a divider
                            if (index != controller.projects.value.length - 1) {
                              return Column(
                                children: [
                                  ProjectListItem(
                                    project: project,
                                    index: index,
                                    length: controller.projects.value.length,
                                  ),
                                  Divider(),
                                ],
                              );
                            }
                            return ProjectListItem(
                              project: project,
                              index: index,
                              length: controller.projects.value.length,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Colors.grey.shade900,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'tickets_noPastProjects'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
