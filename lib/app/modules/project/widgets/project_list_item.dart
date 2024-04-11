import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onax_app/app/data/models/project_model.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class ProjectListItem extends StatelessWidget {
  const ProjectListItem({
    super.key,
    required this.project,
    required this.index,
    required this.length,
  });

  final Project project;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListTile(
      title: Text(
        project.name ?? "projects_noName".tr,
        style: TextStyle(
          fontSize: textTheme.labelLarge!.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        project.initialDate != null
            ? DateFormat("MM/dd/yyyy")
                .format(DateTime.parse(project.initialDate))
            : "projects_noInitialDate".tr,
        style: TextStyle(
          fontSize: textTheme.labelMedium!.fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              project.status ?? "projects_noStatus".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: textTheme.labelSmall!.fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
      onTap: () => Get.toNamed(Routes.UPDATE_PROJECT, arguments: project),
    );
  }
}
