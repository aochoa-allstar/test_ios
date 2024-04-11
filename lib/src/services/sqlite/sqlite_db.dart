import 'dart:io';

import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseSQLite {
  // static final DataBaseSQLite dataBaseSQLite = new DataBaseSQLite().internal();
  // factory DataBaseSQLite() => dataBaseSQLite;
  // DataBaseSQLite.internal();
  //final _prefs = SharedPrefs();
  static Database? db;
  late String path;
  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'onaxDB.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    print('DB sqlite created succefully');
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          
          CREATE TABLE customer (
            idKnt INTEGER PRIMARY KEY AUTOINCREMENT,
            id integer,
            name TEXT
          )
          ''');

    await db.execute('''
          
          CREATE TABLE destinations (
            idKnt INTEGER PRIMARY KEY AUTOINCREMENT,
            id integer,
            name TEXT
          )
          ''');

    await db.execute('''
          
          CREATE TABLE origins (
            idKnt INTEGER PRIMARY KEY AUTOINCREMENT,
            id integer,
            name TEXT
          )
          ''');

    //trailers and trucks only type = trailers. by its for both
    await db.execute('''
          
          CREATE TABLE equipment (
            idKnt INTEGER PRIMARY KEY AUTOINCREMENT,
            worker_id INTEGER,
            id integer,
            number TEXT,
            type TEXT,
      plate TEXT,
     vin TEXT,
     make TEXT,
      model TEXT,
     year TEXT,
     inactive INTEGER
          )
          ''');

    await db.execute('''
        CREATE TABLE workers(
          id INTEGER,
          name TEXT,
          email TEXT,
          language TEXT,
          status TEXT,
          type TEXT
         
        )
     ''');

    //Tickets
    await db.execute(''' 
      CREATE TABLE tickets (
          idKey INTEGER PRIMARY KEY AUTOINCREMENT,
          id INTEGER,
         shift_id INTEGER,
        company_man_id INTEGER,
        customer TEXT,
        customer_id INTEGER,
        destination_id INTEGER,
        project_id INTEGER,
        date TEXT,
        equipment_id INTEGER, 
        worker_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        depart_timestamp TEXT,
        arrived_timestamp TEXT,
        finished_timestamp TEXT,
        arrived_photo TEXT,
        finished_photo TEXT,
        description TEXT,
        work_hours INTEGER,
        supervisor_id INTEGER,
        worker_type_id INTEGER,
        supervisor_work_hours TEXT
      )
    ''');
    await db.execute(''' 
      CREATE TABLE ticketsFinished (
          idKey INTEGER PRIMARY KEY AUTOINCREMENT,
          id INTEGER,
         shift_id INTEGER,
        customer TEXT,
        customer_id INTEGER,
        destination_id INTEGER,
        project_id INTEGER,
        date TEXT,
        equipment_id INTEGER, 
        worker_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        depart_timestamp TEXT,
        arrived_timestamp TEXT,
        finished_timestamp TEXT,
        arrived_photo TEXT,
        finished_photo TEXT,
        description TEXT,
       worker_type_id INTEGER,
        work_hours INTEGER
      )
    ''');
    //INSPECTIONS
    await db.execute('''
    CREATE TABLE jsas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customer_id INTEGER,
      project_id INTEGER,
      date TEXT,
      hazard TEXT,
      controls TEXT,
      worker_id INTEGER, 
      job_description TEXT,
        company TEXT,
        gps TEXT,
        helper INTEGER,
        helper2_id INTEGER,
       
        steel_toad_shoes INTEGER,
        hard_hat  INTEGER,
        safety_glasses  INTEGER,
        h2s_monitor  INTEGER,
        fr_clothing  INTEGER,
        fall_protection  INTEGER,
        hearing_protection  INTEGER,
        respirator INTEGER,
        other_safety_equipment  INTEGER,
        other_safety_equipment_name TEXT,
        fail_potential  INTEGER,
        overhead_lift  INTEGER,
        h2s INTEGER,
        pinch_points  INTEGER,
        slip_trip  INTEGER,
        sharp_objects  INTEGER,
        power_tools  INTEGER,
        hot_cold_surface  INTEGER,
        pressure  INTEGER,
        dropped_objects  INTEGER,
        heavy_lifting  INTEGER,
        weather  INTEGER,
        flammables  INTEGER,
        chemicals  INTEGER,
        other_hazards  INTEGER,
        other_hazards_name TEXT,
        confined_spaces_permits  INTEGER,
        hot_work_permit  INTEGER,
        excavation_trenching  INTEGER,
        one_call  INTEGER,
        one_call_num TEXT,
        lock_out_tag_out  INTEGER,
        fire_extinguisher  INTEGER,
        inspection_of_equipment  INTEGER,
        msds_review  INTEGER,
        ladder  INTEGER,
        permits  INTEGER,
        other_check_review  INTEGER,
        other_check_review_name TEXT,
        weather_condition  INTEGER,
        weather_condition_description TEXT,
        wind_direction  INTEGER,
        wind_direction_description TEXT,
        task TEXT,
        muster_points TEXT,
        recommended_actions_and_procedures TEXT,
        signature1 TEXT,
        signature2 TEXT,
        signature3 TEXT,
        coords TEXT,
        location TEXT
    )
 ''');

    await db.execute(''' 
    CREATE TABLE inspections(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
       date TEXT,
        location TEXT,
        equipment_id INTEGER,
        odometer_begin DECIMAL,
        odometer_end DECIMAL,
        remarks TEXT,
        worker_id INTEGER, 
        vehicle_condition  INTEGER,
        defects_corrected  INTEGER,
        defects_not_corrected  INTEGER,
        trailer_1_equipment_id INTEGER,
        trailer_2_equipment_id INTEGER,
        v_condition_signature TEXT,
        driver_signature TEXT,
        checkBoxItems TEXT
    )
    ''');

    await db.execute(''' 
    CREATE TABLE project (
      idKey INTEGER PRIMARY KEY AUTOINCREMENT,
      id INTEGER,
      customer_id INTEGER,
      name TEXT,
      initial_date TEXT
    )
    ''');

    await db.execute(''' 
    CREATE TABLE shift (
      idKey INTEGER PRIMARY KEY AUTOINCREMENT,
      id INTEGER,
     worker_id INTEGER,
        start_time TEXT,
        end_time TEXT,
        equipment_id INTEGER,
        helper_id INTEGER,
        helper2_id INTEGER,
        helper3_id INTEGER,
        active INTEGER,
        temId TEXT,
        worker_type_id INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE ticketDescription (
      idKey INTEGER PRIMARY KEY AUTOINCREMENT,
      id INTEGER,
      name TEXT,
        name_spanish TEXT,
      `text` TEXT
    )
''');

    await db.execute('''
      CREATE TABLE companyMen (
        idKnt INTEGER PRIMARY KEY AUTOINCREMENT,
        id integer,
        customer_id integer,
        name TEXT
      )
    ''');

    await db.execute(''' 
    CREATE TABLE location (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      latitude TEXT,
      longitude TEXT,
      speed DECIMAL,
      status TEXT,
      ticket_id INTEGER,
      worker_id INTEGER,
      init_date TEXT,
      end_date TEXT
    )
    ''');

    //accountPrefs version to upate form api or new columns added.
    //for a future porpose o new tables. abbreviation TEXT,
    AccountPrefs.versionDB = '1';
  }

  openDB() {
    openDatabase(path);
  }

  closeDB() async {
    await db?.close();
  }

  dropDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, 'onaxDB.db');
    deleteDatabase(path);
  }
}
