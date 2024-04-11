import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onax_app/app/data/enums/preferences_enum.dart';
import 'package:onax_app/core/services/init.dart';
import 'package:onax_app/core/services/preferences_service.dart';

import 'package:onax_app/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  await initializeCoreServices();

  PreferencesService preferences = Get.find();
  String localeCode;

  if (preferences.getPreference(Preferences.language) != null) {
    localeCode = preferences.getPreference(Preferences.language);
  } else {
    localeCode = Get.deviceLocale != null ? Get.deviceLocale!.languageCode : 'en_US';
  }

  runApp(
    GetMaterialApp(
      title: 'Onax App',
      translationsKeys: AppTranslation.translations,
      initialRoute: AppPages.INITIAL,
      // locale: Locale('es', 'MX'),
      locale: Locale(localeCode),
      getPages: AppPages.routes,
    ),
  );
}
