import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/preferences_enum.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';

class AuthGuard extends GetMiddleware {
  RouteSettings? redirect(String? route) {
    PreferencesService preferences = Get.find();

    return preferences.getPreference(Preferences.sessionToken) == null
        ? RouteSettings(name: Routes.LOGIN)
        : null;
  }
}
