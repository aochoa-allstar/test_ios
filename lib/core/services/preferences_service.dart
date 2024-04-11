import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onax_app/app/data/enums/languages_enum.dart';
import 'package:onax_app/app/data/enums/preferences_enum.dart';
import 'package:onax_app/app/data/enums/user_types_enum.dart';
import 'package:onax_app/app/data/models/session_model.dart';

class PreferencesService extends GetxController implements GetxService {
  Future<PreferencesService> init() async => this;

  late GetStorage storage;

  @override
  void onInit() async {
    storage = GetStorage();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setPreference(Preferences preference, dynamic value) {
    storage.write(preference.key, value);

    // // Update locale when overwriting the language preference
    // if (preference == Preferences.language)
    //   Get.updateLocale(value == Languages.english.localeCode
    //       ? Locale('en', 'US')
    //       : Locale('es', 'MX'));
  }

  dynamic getPreference(Preferences preference) {
    return storage.read(preference.key);
  }

  Session getSession() {
    return Session(
      userId: storage.read(Preferences.userId.key),
      userType: UserTypes.values[storage.read(Preferences.userType.key)],
      sessionToken: storage.read(Preferences.sessionToken.key),
      language:
          storage.read(Preferences.language.key) == Languages.english.localeCode
              ? Languages.english
              : Languages.spanish,
    );
  }

  void setSession(Session session) {
    storage.write(Preferences.userId.key, session.userId);
    storage.write(Preferences.userType.key, session.userType.index);
    storage.write(Preferences.sessionToken.key, session.sessionToken);
    storage.write(Preferences.language.key, session.language.localeCode);
  }

  dynamic removeSession() {
    return storage.erase();
  }

  changeLanguage() {
    // print('updateLang');
    setPreference(
      Preferences.language,
      getPreference(Preferences.language) == Languages.english.localeCode
          ? Languages.spanish.localeCode
          : Languages.english.localeCode,
    );
    Get.updateLocale(
      Locale(
        getPreference(Preferences.language),
      ),
    );
  }

  changeLanguageByValue(String lang) {
    setPreference(Preferences.language, lang);
    Get.updateLocale(
      Locale(
        getPreference(Preferences.language),
      ),
    );
  }
}
