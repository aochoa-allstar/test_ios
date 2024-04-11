import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/enums/database_tables_enum.dart';
import 'package:onax_app/app/data/models/session_model.dart';
import 'package:onax_app/app/routes/api_routes.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:onax_app/core/services/preferences_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SQLiteService extends GetxController implements GetxService {
  Future<SQLiteService> init() async => this;
  PreferencesService preferencesService = Get.find();

  Database? db;
  late String path;

  @override
  void onInit() async {
    await initDataBase();
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

  Future _onCreate(Database db, int version) async {
    //Sync table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.sync.tableName} (
       endpoint TEXT,
       body TEXT,
       synced BOOLEAN
      )
    ''');

    //Current Shift
    await db.execute('''
      CREATE TABLE ${DatabaseTables.currentShift.tableName} (
        id INTEGER,
        worker_id INTEGER,
        start_time TEXT,
        end_time TEXT,
        equipment_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        active INTEGER,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        temId TEXT,
        worker_type_id INTEGER
      )
    ''');
    //Current Ticket
    await db.execute('''
      CREATE TABLE ${DatabaseTables.currentTicket.tableName} (
        id INTEGER,
        prefix TEXT,
        company_id INTEGER,
        shift_id INTEGER,
        company_man_id INTEGER,
        customer TEXT,
        customer_id INTEGER,
        destination_id INTEGER,
        project_id INTEGER,
        date TEXT,
        equipment_id INTEGER,
        worker_type_id INTEGER,
        worker_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        depart_timestamp TEXT,
        arrived_timestamp TEXT,
        finished_timestamp TEXT,
        work_hours INTEGER,
        arrived_photo TEXT,
        finished_photo TEXT,
        description TEXT,
        supervisor_id INTEGER,
        supervisor_work_hours INTEGER,
        additional_equipment_id INTEGER,
        invoice_id INTEGER,
        signature TEXT,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        first_inspection TEXT,
        final_inspection TEXT,
        date_formatted TEXT,
        project TEXT,
        workers TEXT
      )
    ''');
    //Finished Tickets
    await db.execute('''
      CREATE TABLE ${DatabaseTables.finishedTickets.tableName} (
        id INTEGER,
        prefix TEXT,
        company_id INTEGER,
        shift_id INTEGER,
        company_man_id INTEGER,
        customer TEXT,
        customer_id INTEGER,
        destination_id INTEGER,
        project_id INTEGER,
        date TEXT,
        equipment_id INTEGER,
        worker_type_id INTEGER,
        worker_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        depart_timestamp TEXT,
        arrived_timestamp TEXT,
        finished_timestamp TEXT,
        work_hours INTEGER,
        arrived_photo TEXT,
        finished_photo TEXT,
        description TEXT,
        supervisor_id INTEGER,
        supervisor_work_hours INTEGER,
        additional_equipment_id INTEGER,
        invoice_id INTEGER,
        signature TEXT,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        first_inspection TEXT,
        final_inspection TEXT,
        date_formatted TEXT,
        project TEXT,
        workers TEXT
      )
    ''');
    //JSAs
    await db.execute('''
    CREATE TABLE ${DatabaseTables.jsas.tableName}(
            id INTEGER,
            company_id INTEGER,
            destination_id INTEGER,
            customer_id INTEGER,
            project_id INTEGER,
            ticket_id INTEGER,
            date TEXT,
            hazard TEXT,
            controls TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT,
            worker_id INTEGER,
            job_description TEXT,
            gps TEXT,
            helper INTEGER,
            helper2_id INTEGER,
            helper3_id INTEGER,
            other_worker_id INTEGER,
            steel_toad_shoes TEXT,
            hard_hat TEXT,
            safety_glasses TEXT,
            h2s_monitor TEXT,
            fr_clothing TEXT,
            fall_protection TEXT,
            hearing_protection TEXT,
            respirator TEXT,
            other_safety_equipment TEXT,
            other_safety_equipment_name TEXT,
            fail_potential TEXT,
            overhead_lift TEXT,
            h2s TEXT,
            pinch_points TEXT,
            slip_trip TEXT,
            sharp_objects TEXT,
            power_tools TEXT,
            hot_cold_surface TEXT,
            pressure TEXT,
            dropped_objects TEXT,
            heavy_lifting TEXT,
            weather TEXT,
            flammables TEXT,
            chemicals TEXT,
            other_hazards TEXT,
            other_hazards_name TEXT,
            confined_spaces_permits TEXT,
            hot_work_permit TEXT,
            excavation_trenching TEXT,
            one_call TEXT,
            one_call_num TEXT,
            lock_out_tag_out TEXT,
            fire_extinguisher TEXT,
            inspection_of_equipment TEXT,
            msds_review TEXT,
            ladder TEXT,
            permits TEXT,
            other_check_review TEXT,
            other_check_review_name TEXT,
            weather_condition TEXT,
            weather_condition_description TEXT,
            wind_direction TEXT,
            wind_direction_description TEXT,
            task TEXT,
            muster_points TEXT,
            recommended_actions_and_procedures TEXT,
            signature1 TEXT,
            signature2 TEXT,
            signature3 TEXT,
            signature4 TEXT,
            coords TEXT,
            location TEXT,
            project_name TEXT,
            project TEXT,
            additional_signatures TEXT
      )
    ''');
    //Projects
    await db.execute('''
      CREATE TABLE ${DatabaseTables.projects.tableName} (
            id INTEGER,
            company_id INTEGER,
            customer_id INTEGER,
            company_men_id INTEGER,
            table_income_tax_state_id INTEGER,
            project_type TEXT,
            name TEXT,
            initial_date TEXT,
            estimated_completion TEXT,
            cost INTEGER,
            latitude INTEGER,
            longitude  INTEGER,
            description TEXT,
            status TEXT,
            po_afe TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Customers
    await db.execute('''
      CREATE TABLE ${DatabaseTables.customers.tableName} (
            id INTEGER,
            name TEXT,
            email TEXT,
            email_verified_at TEXT,
            password TEXT,
            invoice_email TEXT,
            phone TEXT,
            payment_days TEXT,
            remember_token TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Customers Pivot
    await db.execute('''
      CREATE TABLE ${DatabaseTables.customersPivot.tableName} (
            company_id INTEGER,
            customer_id INTEGER,
            company_created_at TEXT,
            company_updated_at TEXT
      )
    ''');
    //Equipment type truck
    await db.execute('''
      CREATE TABLE ${DatabaseTables.trucks.tableName} (
            id INTEGER,
            company_id INTEGER,
            worker_id INTEGER,
            equipment_type_id INTEGER,
            number TEXT,
            plate TEXT,
            vin TEXT,
            make TEXT,
            model TEXT,
            year INTEGER,
            inactive BOOLEAN,
            rate_type TEXT,
            rate TEXT,
            type TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Equipments
    await db.execute('''
      CREATE TABLE ${DatabaseTables.equipments.tableName} (
            id INTEGER,
            company_id INTEGER,
            worker_id INTEGER,
            equipment_type_id INTEGER,
            number TEXT,
            plate TEXT,
            vin TEXT,
            make TEXT,
            model TEXT,
            year INTEGER,
            inactive BOOLEAN,
            rate_type TEXT,
            rate TEXT,
            type TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Helpers
    await db.execute('''
      CREATE TABLE ${DatabaseTables.helpers.tableName} (
            id INTEGER,
            company_id INTEGER,
            name TEXT,
            email TEXT,
            password TEXT,
            password_token TEXT,
            birthdate TEXT,
            phone TEXT,
            address TEXT,
            gender TEXT,
            language TEXT,
            status TEXT,
            worker_type_id INTEGER,
            who_edited_it INTEGER,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT,
            signature TEXT,
            completed_paperwork TEXT,
            inactive TEXT,
            inactive_observations TEXT,
            customer_rate TEXT,
            worker_rate TEXT,
            type TEXT
      )
    ''');
    //Supervisors
    await db.execute('''
      CREATE TABLE ${DatabaseTables.supervisors.tableName} (
            id INTEGER,
            name TEXT
      )
    ''');
    //Worker Types
    await db.execute('''
      CREATE TABLE ${DatabaseTables.workerTypes.tableName} (
            id INTEGER,
            company_id INTEGER,
            sorting_priority INTEGER,
            type TEXT,
            helpers_quantity INTEGER,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Company men
    await db.execute('''
      CREATE TABLE ${DatabaseTables.CompanyMen.tableName} (
            id INTEGER,
            company_id INTEGER,
            customer_id INTEGER,
            name TEXT,
            phone TEXT,
            email TEXT,
            password TEXT,
            remember_token TEXT,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT
      )
    ''');
    //Current Worker
    await db.execute('''
      CREATE TABLE ${DatabaseTables.currentWorker.tableName} (
            id INTEGER,
            company_id INTEGER,
            name TEXT,
            email TEXT,
            password TEXT,
            password_token TEXT,
            birthdate TEXT,
            phone TEXT,
            address TEXT,
            gender TEXT,
            language TEXT,
            status TEXT,
            worker_type_id INTEGER,
            who_edited_it INTEGER,
            created_at TEXT,
            updated_at TEXT,
            deleted_at TEXT,
            signature TEXT,
            completed_paperwork TEXT,
            inactive TEXT,
            inactive_observations TEXT,
            customer_rate TEXT,
            worker_rate TEXT,
            type TEXT
      )
    ''');
    //

    //Edit and to Sync entities
  }

  Future<Map<String, dynamic>> getTable(DatabaseTables table) async {
    if (db == null) {
      await initDataBase();
    }
    final List<Map<String, dynamic>> maps = await db!.query(table.tableName);
    return {'statusCode': 200, 'success': true, 'data': maps};
  }

  Future<Map<String, dynamic>> getTableWhere(
      DatabaseTables table, String where, List<dynamic> whereArgs) async {
    if (db == null) {
      await initDataBase();
    }
    final List<Map<String, dynamic>> maps =
        await db!.query(table.tableName, where: where, whereArgs: whereArgs);
    return {'statusCode': 200, 'success': true, 'data': maps};
  }

  Future<Map<String, dynamic>> getTableByRawQuery(String query) async {
    if (db == null) {
      await initDataBase();
    }
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    return {'statusCode': 200, 'success': true, 'data': maps};
  }

  Future updateTable(DatabaseTables table, Map<String, dynamic> data) async {
    if (db == null) {
      await initDataBase();
    }
    await db!.delete(table.tableName);
    await db!.insert(table.tableName, data);
  }

  Future insertIntoTable(
      DatabaseTables table, Map<String, dynamic> data) async {
    if (db == null) {
      await initDataBase();
    }
    await db!.insert(table.tableName, data);
  }

  Future deleteTable(DatabaseTables table) async {
    if (db == null) {
      await initDataBase();
    }
    await db!.delete(table.tableName);
  }

  Future deleteRowInTable(DatabaseTables table, int id, String where) async {
    if (db == null) {
      await initDataBase();
    }
    await db!.delete(table.tableName, where: where, whereArgs: [id]);
  }

  Future populateSyncTable(String endpoint, dynamic data) async {
    await insertIntoTable(DatabaseTables.sync, {
      'endpoint': endpoint,
      'body': jsonEncode(data),
      'synced': 0,
    });
  }

  Future<void> initDataBase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'onaxDB.db');
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
    log('Path: $path', name: 'DataBase');
  }

  Future<void> syncDataBase() async {
    final dataBaseResponse = await getTable(DatabaseTables.sync);
    final data = dataBaseResponse['data'] as List<Map<String, dynamic>>;

    //First we check if we had any data to sync
    if (data.isEmpty) return;

    //We wait 3 seconds beacause in some devices the reconnect takes time.
    //We need to wait for the connection to be stable
    await Future.delayed(Duration(seconds: 3));

    Get.snackbar(
      'snackbar_network_sync'.tr,
      'snackbar_network_sync'.tr,
      colorText: Colors.white,
      backgroundColor: Colors.blue.withAlpha(150),
      isDismissible: true,
      margin: EdgeInsets.all(16),
    );

    //We start the sync process
    final Session session = await preferencesService.getSession();
    final token = session.sessionToken;
    final value = await http.post(
      Uri.parse('${ApiRoutes.BASE + ApiRoutes.sync}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: jsonEncode(data),
    );

    //If the sync was successful we delete the data from the local database
    //and send a message to the user
    if (value.statusCode == 200) {
      await deleteTable(DatabaseTables.sync);
      Get.offAllNamed(Routes.TABS);
      Get.snackbar(
        'snackbar_network_synced'.tr,
        'snackbar_network_synced'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.blue.withAlpha(150),
        isDismissible: true,
        margin: EdgeInsets.all(16),
      );
    } else {
      Get.snackbar(
        'snackbar_network_network_error_title'.tr,
        'snackbar_network_sync_failed'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.red.withAlpha(150),
        isDismissible: true,
        margin: EdgeInsets.all(16),
      );
    }
  }

  dropDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'onaxDB.db');
    deleteDatabase(path);
  }

  restartDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'onaxDB.db');
    await deleteDatabase(path);

    initDataBase();
    Get.offAllNamed(Routes.TABS);
  }
}
