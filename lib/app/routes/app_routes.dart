part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  // Authentication
  static const LOGIN = _Paths.AUTH + _Paths.LOGIN;
  static const FORGOT_PASSWORD = _Paths.AUTH + _Paths.FORGOT_PASSWORD;

  // Main page/ Initial route
  static const TABS = _Paths.TABS;

  // Shift
  static const CREATE_SHIFT = _Paths.SHIFT + _Paths.CREATE;

  // Tickets
  static const LIST_TICKETS = _Paths.TICKET;
  static const CREATE_TICKET = _Paths.TICKET + _Paths.CREATE;
  static const UPDATE_TICKET = _Paths.TICKET + _Paths.UPDATE;
  static const VIEW_TICKET = _Paths.TICKET + _Paths.VIEW;

  // JSAs
  static const JSAS = _Paths.JSA;
  static const CREATE_JSA = _Paths.JSA + _Paths.CREATE;
  static const UPDATE_JSA = _Paths.JSA + _Paths.UPDATE;
  static const VIEW_JSA = _Paths.JSA + _Paths.VIEW;

  // Projects
  static const PROJECTS = _Paths.PROJECT;
  static const CREATE_PROJECT = _Paths.PROJECT + _Paths.CREATE;
  static const UPDATE_PROJECT = _Paths.PROJECT + _Paths.UPDATE;

  // Account
  static const ACCOUNT = _Paths.ACCOUNT;

  // Inspection
  static const INSPECTION = _Paths.INSPECTION;
  static const CREATE_PRE_INSPECTION =
      _Paths.INSPECTION + _Paths.CREATE + "/pre";
  static const CREATE_POST_INSPECTION =
      _Paths.INSPECTION + _Paths.CREATE + "/post";
}

abstract class _Paths {
  _Paths._();
  // Authentication
  static const AUTH = '/auth';
  static const LOGIN = '/login';
  static const FORGOT_PASSWORD = '/forgot-password';

  // Main page / Initial route
  static const TABS = '/tabs';

  // Modules
  static const SHIFT = '/shift';
  static const TICKET = '/ticket';
  static const JSA = '/jsa';
  static const PROJECT = '/project';
  static const INSPECTION = '/inspection';
  static const ACCOUNT = '/account';

  // Module Sub-pages
  static const CREATE = '/create';
  static const UPDATE = '/update/:';
  static const VIEW = '/view';
}
