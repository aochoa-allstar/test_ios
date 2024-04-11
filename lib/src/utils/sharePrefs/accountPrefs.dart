import 'package:shared_preferences/shared_preferences.dart';

class AccountPrefs {
  /*static final AccountPrefs _accountPrefs = new AccountPrefs();

  factory AccountPrefs() {
    return _accountPrefs;
  }*/
  static late SharedPreferences _prefs;
  static String _token = '';
  static String _name = '';
  static String _email = '';
  static String _picProfile = '';
  static String _type = '';
  static String _status = '';
  static int _inactive = 0;
  static int _saveData = 0;
  static int _idUser = 0;
  static bool _isDarkTheme = false;
  static int _currentShift = 0;
  static int _hasOpenTicke = 0;
  static bool _permissionGranted = false;
  static bool _locationEnabled = false;
  static bool _statusConnection = false;
  static String _versionDB = '';
  static String _locationServer = '';
  static String _statusTicket = 'inactive_ticket';
  static String _language = '';
  static int _workerTypeID = 0;
  static String _hasOpenTicketPrefix = '';

  static initPrefs() async {
    print('getting prefs');
    // return await SharedPreferences.getInstance();
    return true;
    // print('returning prefs');
    // return _prefs;
  }

  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString('token', token);
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString('email', email);
  }

  static String get picProfile {
    return _prefs.getString('picProfile') ?? _picProfile;
  }

  static set picProfile(String picProfile) {
    _picProfile = picProfile;
    _prefs.setString('picProfile', picProfile);
  }

  static bool get isDarkTheme {
    return _prefs.getBool('isDarkTheme') ?? _isDarkTheme;
  }

  static set isDarkTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    _prefs.setBool('isDarkTheme', isDarkTheme);
  }

  static String get type {
    return _prefs.getString('type') ?? _type;
  }

  static set type(String type) {
    _type = type;
    _prefs.setString('type', type);
  }

  static String get status {
    return _prefs.getString('status') ?? _status;
  }

  static set status(String status) {
    _status = status;
    _prefs.setString('status', status);
  }

  static int get inactive {
    return _prefs.getInt('inactive') ?? _inactive;
  }

  static set inactive(int inactive) {
    _inactive = inactive;
    _prefs.setInt('inactive', inactive);
  }

  static int get saveData {
    return _prefs.getInt('saveData') ?? _saveData;
  }

  static set saveData(int saveData) {
    _saveData = saveData;
    _prefs.setInt('saveData', saveData);
  }

  static int get idUser {
    return _prefs.getInt('idUser') ?? _idUser;
  }

  static set idUser(int idUser) {
    _idUser = idUser;
    _prefs.setInt('idUser', idUser);
  }

  static int get currentShift {
    return _prefs.getInt('currentShift') ?? _currentShift;
  }

  static set currentShift(int currentShift) {
    _currentShift = currentShift;
    _prefs.setInt('currentShift', currentShift);
  }

  static int get hasOpenTicke {
    return _prefs.getInt('hasOpenTicke') ?? _hasOpenTicke;
  }

  static set hasOpenTicke(int hasOpenTicke) {
    _hasOpenTicke = hasOpenTicke;
    _prefs.setInt('hasOpenTicke', hasOpenTicke);
  }

  static bool get permissionGranted {
    return _prefs.getBool('_permissionGranted') ?? _permissionGranted;
  }

  static set permissionGranted(bool permissionGranted) {
    _permissionGranted = permissionGranted;
    _prefs.setBool('_permissionGranted', _permissionGranted);
  }

  static bool get locationEnabled {
    return _prefs.getBool('_locationEnabled ') ?? _locationEnabled;
  }

  static set locationEnabled(bool locationEnabled) {
    _locationEnabled = locationEnabled;
    _prefs.setBool('_locationEnabled ', _locationEnabled);
  }

  static bool get statusConnection {
    return _prefs.getBool('_statusConnection') ?? _statusConnection;
  }

  static set statusConnection(bool statusConnection) {
    _statusConnection = statusConnection;
    _prefs.setBool('_statusConnection', _statusConnection);
  }

  static String get versionDB {
    return _prefs.getString('versionDB') ?? _versionDB;
  }

  static set versionDB(String versionDB) {
    _versionDB = versionDB;
    _prefs.setString('versionDB', versionDB);
  }

  static String get locationServer {
    return _prefs.getString('locationServer') ?? _locationServer;
  }

  static set locationServer(String locationServer) {
    _locationServer = locationServer;
    _prefs.setString('locationServer', locationServer);
  }

  static String get statusTicket {
    return _prefs.getString('statusTicket') ?? _statusTicket;
  }

  static set statusTicket(String statusTicket) {
    _statusTicket = statusTicket;
    _prefs.setString('statusTicket', statusTicket);
  }

  static String get language {
    return _prefs.getString('language') ?? _language;
  }

  static set language(String language) {
    _language = language;
    _prefs.setString('language', language);
  }

  static String get hasOpenTicketPrefix {
    return _prefs.getString('hasOpenTicketPrefix') ?? _hasOpenTicketPrefix;
  }

  static set hasOpenTicketPrefix(String hasOpenTicketPrefix) {
    _hasOpenTicketPrefix = hasOpenTicketPrefix;
    _prefs.setString('hasOpenTicketPrefix', hasOpenTicketPrefix);
  }

  static int get workerTypeID {
    return _prefs.getInt('workerTypeID') ?? 0;
  }

  static set workerTypeID(int workerTypeID) {
    _workerTypeID = workerTypeID;
    _prefs.setInt('workerTypeID', workerTypeID);
  }
}
