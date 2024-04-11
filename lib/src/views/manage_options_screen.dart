import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:onax_app/src/controllers/manageSettingController.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:onax_app/src/views/components/manage_options/changePassword.dart';

class ManageOptionScreen extends StatelessWidget {
  ManageOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManageSettingsController _managetSetController =
        ManageSettingsController();
    return Scaffold(
      body: GetBuilder<ManageSettingsController>(
        init: (_managetSetController),
        builder: (_) => Center(
          child: Column(
            children: [
              Visibility(
                visible: AccountPrefs.currentShift > 0,
                child: TextButton(
                  onPressed: () async {
                    AccountPrefs.statusConnection == true
                        ? await _.endShift()
                        : await _.endShiftNOtWifi();
                  },
                  child: Text('ticket_finish_endshift'.tr),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    _.logout();
                  },
                  child: Text('options_logout'.tr)),
              TextButton(
                  onPressed: () async {
                    //_.logout();
                    return Get.to(
                      () => ManageChangePassword(controllers: _),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                  child: Text('options_changepsw'.tr)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('utils_language'.tr),
                    ElevatedButton(
                      onPressed: () {
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);
                        print(locale);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.locale?.languageCode == 'en'
                            ? Colors.blue // Cambiar el color para el idioma inglés
                            : Colors.grey, // Cambiar el color para otros idiomas
                      ),
                      child: Text('English'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var locale = Locale('es', 'MX');
                        Get.updateLocale(locale);
                        print(locale);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.locale?.languageCode == 'es'
                            ? Colors.blue // Cambiar el color para el idioma español
                            : Colors.grey, // Cambiar el color para otros idiomas
                      ),
                      child: Text('Español'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
