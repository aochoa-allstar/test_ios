import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/languages_enum.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  AccountView({Key? key}) : super(key: key);

  final AccountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    controller.getSyncTable();

    return Scaffold(
      appBar: AppBar(
        title: Text('account_title'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "account_language".tr,
                style: TextStyle(
                  fontSize: theme.textTheme.labelSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text("account_change_language".tr),
              trailing: SizedBox(
                width: 135,
                child: FormBuilderDropdown(
                    name: "language",
                    initialValue: controller.session.value!.language.localeCode,
                    items: [
                      DropdownMenuItem(
                        value: Languages.english.localeCode,
                        child: Text("languages_en".tr),
                      ),
                      DropdownMenuItem(
                        value: Languages.spanish.localeCode,
                        child: Text("languages_es".tr),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onChanged: (value) {
                      controller.preferences.changeLanguageByValue(value!);
                    }),
              ),
            ),
            ListTile(
              title: Text(
                "account_offline_mode".tr,
                style: TextStyle(
                  fontSize: theme.textTheme.labelSmall!.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(() => controller.loadingOfflineData.value
                ? ListTile(
                    title: Text("account_sync".tr),
                    subtitle: Text("account_entities".tr),
                    trailing: SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  )
                : ListTile(
                    title: Text("account_sync".tr),
                    onTap: () => controller.syncDataBase(),
                    subtitle: Text(
                      "account_entities".tr +
                          controller.syncTable.value.length.toString(),
                    ),
                    trailing: Icon(
                      Icons.sync_rounded,
                      size: 30,
                      color: Color.fromRGBO(36, 54, 101, 1.0),
                    ),
                  )),
            ListTile(
              title: Text("account_share".tr),
              subtitle: Text("account_share_text".tr),
              onTap: () => controller.shareDatabaseCSVViaEmail(),
              trailing: Icon(
                Icons.share_rounded,
                size: 30,
                color: Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ),
            ListTile(
              title: Text("account_delete".tr),
              subtitle: Text("account_delete_text".tr),
              onTap: () => controller.deleteDataBase(),
              trailing: Icon(
                Icons.delete_forever_rounded,
                size: 30,
                color: Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ),
            Expanded(child: const SizedBox.shrink()),
            RoundedLoadingButton(
              borderRadius: 16,
              color: Colors.red.shade400,
              controller: controller.logOutButton,
              onPressed: () => controller.logOut(),
              child: Text(
                'account_sign_out'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
