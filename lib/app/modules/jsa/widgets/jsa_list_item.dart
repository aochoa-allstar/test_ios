import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/jsa_model.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class JSAListItem extends StatelessWidget {
  const JSAListItem({
    super.key,
    required this.jsa,
    required this.index,
    required this.length,
  });

  final JSA jsa;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListTile(
      title: Text(
        jsa.customerId != null
            ? jsa.customer?.name ?? "jsas_noCustomer".tr
            : "jsas_noCustomer".tr,
        style: TextStyle(
          fontSize: textTheme.labelLarge!.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        jsa.date.toString(),
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
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              jsa.project != null
                  ? jsa.project["name"].toString()
                  : "jsas_noProject".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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
      onTap: () {
        Get.toNamed(Routes.VIEW_JSA, arguments: jsa.id);
      },
    );
  }
}
