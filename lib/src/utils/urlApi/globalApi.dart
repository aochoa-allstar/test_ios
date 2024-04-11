// ignore: file_names
class GlobalApi {
  // final String api = 'https://app.onaxllc.com/api';
  final String api = 'http://192.168.100.39:8000/api';
  // final String api = 'http://10.0.2.2:8000/api';
  // 'https://beta.onaxllc.com/api';  http://10.0.2.2:8000/api  https://app.onaxllc.com/api
  final dynamic _header = {
    "Content-Type": "application/json",
  };

  final String _login = 'login';
  final String _logOut = 'logout';
  final String _resetPassword = 'resetPassword';
  final String _changePassword = 'changePassword';
  final String _equipments = 'equipments';
  final String _trucks = 'trucks';
  final String _companyMen = 'companyMen';
  final String companyMenByCustomer = 'getCompanyMenByApi/';
  final String _origins = 'origins';
  final String _destinations = 'destinations';
  final String _getHelpers = 'getHelpers';
  final String _getCurrentShift = 'getCurrentShift/';
  final String _newShift = 'newShift';
  final String _getInfoOpenTicket = 'getInfoOpenTicket';
  final String _createTicket = 'createTicket';
  final String _getCustomers = 'getCustomers';
  final String _getProjectsInApp = 'getProjectsInApp/';
  final String _getAllProjectsInApp = 'getProjectsAllInApp';
  final String _getTicketActive = 'getTicketActive/';
  final String _getPreviewTickts = 'getPrevTickets/';
  final String _getPreviewTicketsSign = 'getPrevTicketsToSing/';
  final String _getAllTicketDescr = 'getAllTicketDescr';
  final String _updateDepartInTicket = 'updateDepartInTicket';
  final String _updateArriveInTicket = 'updateArriveInTicket';
  final String _updateFinishedInTicket = 'updateFinishedInTicket';
  final String _endShift = 'endShift/';
  final String _createJSAs = 'createJSAs';
  final String _createInspection = 'createInspection';
  final String _trailers = 'trailers';
  final String updateOrStoreTicket = 'storeUpdateFromAppToserverTicket';
  final String _saveSignatureTicket = 'saveSignatureTicket';
  final String addDestination = 'saveDestination';
  final String addProject = 'saveProject';
  final String pdfSign = 'downloadPDFApp';
  final String pdfSingJSA = 'downloadPDFAppJSA';
  final String _supervisors = 'supervisors';
  final String getWorkerTypes = 'getAllWorkerTypes';
  final String getJsas = 'getAllJsasByUser/';
  final String storeSignaturesJsas = 'storeSignature';
  //GETERS
  dynamic get header => _header;
  String get login => _login;
  String get logout => _logOut;
  String get resetPassword => _resetPassword;
  String get changePassword => _changePassword;
  String get equipments => _equipments;
  String get trucks => _trucks;
  String get companyMen => _companyMen;
  String get origins => _origins;
  String get destinations => _destinations;
  String get getHelpers => _getHelpers;
  String get getCurrentShift => _getCurrentShift;
  String get newShift => _newShift;
  String get getInfoOpenTicket => _getInfoOpenTicket;
  String get createTicket => _createTicket;
  String get getCustomers => _getCustomers;
  String get getProjectsInApp => _getProjectsInApp;
  String get getTicketActive => _getTicketActive;
  String get getPrevTickets => _getPreviewTickts;
  String get getAllTicketDescr => _getAllTicketDescr;
  String get updateDepartInTicket => _updateDepartInTicket;
  String get updateArriveInTicket => _updateArriveInTicket;
  String get updateFinishedInTicket => _updateFinishedInTicket;
  String get endShift => _endShift;
  String get createJSAs => _createJSAs;
  String get createInspection => _createInspection;
  String get trailers => _trailers;
  String get getAllProjectsInApp => _getAllProjectsInApp;
  String get getPreviewTicketsSign => _getPreviewTicketsSign;
  String get saveSignatureTicket => _saveSignatureTicket;
  String get supervisors => _supervisors;
}
