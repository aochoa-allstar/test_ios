class ApiRoutes {
  ApiRoutes._();

  static const BASE = 'https://app.onaxllc.com/api';
  // static const BASE = 'https://beta.onaxllc.com/api';
  static const V2 = '/v2';

  // V1
  static const LOG_IN = '/login';
  static const LOG_OUT = '/logout';
  static const RECOVER_PASSWORD = '/changePassword';

  static const CREATE_SHIFT = '/newShift';
  static const GET_CURRENT_SHIFT = '/getCurrentShift';
  static const FINISH_SHIFT = '/endShift';

  static const GET_HELPER_WORKERS = '/getHelpers';
  static const GET_SUPERVISOR_WORKERS = '/supervisors';
  static const GET_WORKER_TYPES = '/getAllWorkerTypes';

  static const GET_ALL_EQUIPMENTS = '/equipments';
  static const GET_TRUCKS = '/trucks';
  static const GET_TRAILERS = '/trailers';

  static const GET_CUSTOMERS = '/getCustomers';

  static const GET_ORIGINS = '/origins';

  static const GET_ALL_COMPANY_MEN = '/companyMen';
  static const GET_CUSTOMER_COMPANY_MEN = '/getCompanyMenByApi';

  static const CREATE_PROJECT = '/saveProject';
  static const GET_CUSTOMER_PROJECTS = '/getProjectsInApp';

  static const CREATE_TICKET = '/createTicket';
  static const GET_TICKET_HISTORY = '/getPrevTickets';
  static const GET_ACTIVE_TICKET = '/getTicketActive';
  static const UPDATE_TICKET_DEPART = '/updateDepartInTicket';
  static const UPDATE_TICKET_ARRIVE = '/updateArriveInTicket';
  static const UPDATE_TICKET_FINISH = '/updateFinishedInTicket';
  static const UPDATE_FINISHED_PHOTO = '/updateTicketDestinyArriveTimePhoto';
  static const VIEW_TICKET_PDF = '/downloadPDFApp';
  static const SIGN_TICKET = '/saveSignatureTicket';

  static const CREATE_JSA = '/createJSAs';
  static const SIGN_JSA = '/storeSignature';
  static const VIEW_JSA_PDF = '/downloadPDFAppJSA';

  // V2
  static const COMPANY_MEN = V2 + '/company-men';
  //TODO: add type in the url /id
  static const CUSTOMERS = V2 + '/customers';

  static const DESTINATIONS = V2 + '/destinations';

  static const LOCATION = V2 + '/locations';

  static const EQUIPMENTS = V2 + '/equipments';
  //TODO:add type in the body to get trailer, truck, machinery

  static const INSPECTIONS = V2 + '/inspections';

  static const JSAS = V2 + '/jsas';

  static const ORIGINS = V2 + '/origins';

  static const PROJECTS = V2 + '/projects';
  //TODO customer_id for only projects from a customer

  static const SHIFT = V2 + '/shifts';
  static const CURRENT_SHIFT = SHIFT + '/active';

  static const TICKET = V2 + '/tickets';
  static const ACTIVE_TICKET = TICKET + '/active';

  static const WORKERS = '/workers';
  static const CURRENT_WORKER = V2 + '/workers';

  static const DRIVER_LOCATIONS = V2 + '/driver-locations';

  static const sync = V2 + '/sync';
}
