enum Preferences { 
  userId('user_id'),
  userType('user_type'),
  sessionToken('session_token'),
  language('language');

  const Preferences(this.key);
  final String key;
}
