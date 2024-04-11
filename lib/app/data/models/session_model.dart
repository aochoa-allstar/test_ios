import 'package:onax_app/app/data/enums/languages_enum.dart';
import 'package:onax_app/app/data/enums/user_types_enum.dart';

class Session {
  late int userId;
  late UserTypes userType;
  late String sessionToken;
  late Languages language;

  Session({
    required this.userId,
    required this.userType,
    required this.sessionToken,
    required this.language
  });

  Session.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    sessionToken = json['session_token'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['id'] = userType;
    data['session_token'] = sessionToken;
    data['language'] = language;
    return data;
  }
}
