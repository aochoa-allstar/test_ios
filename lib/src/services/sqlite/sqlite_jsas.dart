import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

import '../../repositories/models/desty_origin_Model.dart';
import '../../utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class JsasSQL {
  DataBaseSQLite con = DataBaseSQLite();
  final GlobalApi api = GlobalApi();
  //download info.
  insertJSAsSQL(Map data) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO jsas (customer_id, project_id, date , hazard , controls , worker_id ,  job_description ,   company ,   gps ,   helper ,   helper2_id ,   steel_toad_shoes ,   hard_hat  ,   safety_glasses  ,   h2s_monitor  ,   fr_clothing  ,   fall_protection  ,   hearing_protection  ,   respirator ,   other_safety_equipment  ,  other_safety_equipment_name ,   fail_potential  ,   overhead_lift  ,   h2s ,   pinch_points,      slip_trip  ,   sharp_objects  ,   power_tools  ,   hot_cold_surface  ,   pressure  ,   dropped_objects  ,   heavy_lifting  ,   weather  ,   flammables  ,   chemicals  ,   other_hazards  ,   other_hazards_name ,   confined_spaces_permits  ,   hot_work_permit  ,   excavation_trenching  ,   one_call  ,   one_call_num ,   lock_out_tag_out  ,   fire_extinguisher  ,   inspection_of_equipment  ,   msds_review  ,   ladder  ,   permits  ,   other_check_review  ,   other_check_review_name ,   weather_condition  ,   weather_condition_description ,   wind_direction ,   wind_direction_description ,   task ,   muster_points ,   recommended_actions_and_procedures ,   signature1 ,   signature2 ,   signature3 ,   coords ,   location )"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            data['customer_id'],
            data['project_id'],
            data['date'],
            data['hazard'],
            data['controls'],
            data['worker_id'],
            data['job_description'],
            data['company'],
            data['gps'],
            data['helper'],
            data['helper2_id'],
            data['steel_toad_shoes'],
            data['hard_hat'],
            data['safety_glasses'],
            data['h2s_monitor'],
            data['fr_clothing'],
            data['fall_protection'],
            data['hearing_protection'],
            data['respirator'],
            data['other_safety_equipment'],
            data['other_safety_equipment_name'],
            data['fail_potential'],
            data['overhead_lift'],
            data['h2s'],
            data['pinch_points'],
            data['slip_trip'],
            data['sharp_objects'],
            data['power_tools'],
            data['hot_cold_surface'],
            data['pressure'],
            data['dropped_objects'],
            data['heavy_lifting'],
            data['weather'],
            data['flammables'],
            data['chemicals'],
            data['other_hazards'],
            data['other_hazards_name'],
            data['confined_spaces_permits'],
            data['hot_work_permit'],
            data['excavation_trenching'],
            data['one_call'],
            data['one_call_num'],
            data['lock_out_tag_out'],
            data['fire_extinguisher'],
            data['inspection_of_equipment'],
            data['msds_review'],
            data['ladder'],
            data['permits'],
            data['other_check_review'],
            data['other_check_review_name'],
            data['weather_condition'],
            data['weather_condition_description'],
            data['wind_direction'],
            data['wind_direction_description'],
            data['task'],
            data['muster_points'],
            data['recommended_actions_and_procedures'],
            data['signature1'],
            data['signature2'],
            data['signature3'],
            data['coords'],
            data['location'],
          ]);
      print('jsas inserted => $res => ${res}');
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': {'jsasID': res},
      };
      return result;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  //get allEquipment
  getJSAsSQL() async {
    try {
      List<Map<String, dynamic>> listJsas = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.query("jsas");
      if (res!.isNotEmpty) {
        res.map((e) {
          listJsas.add({
            'customer_id': e['customer_id'],
            'project_id': e['project_id'],
            'date': e['date'],
            'hazard': e['hazard'],
            'controls': e['controls'],
            'worker_id': e['worker_id'], //this references to pusher id
            'job_description': e['job_description'],
            'company': e['company'],
            'gps': e['gps'],
            'helper': e['helper'],
            'helper2_id': e['helper2_id'],
            //'other_worker_id':other.text.trim(),
            'steel_toad_shoes': e['steel_toad_shoes'],
            'hard_hat': e['hard_hat'],
            'safety_glasses': e['safety_glasses'],
            'h2s_monitor': e['h2s_monitor'],
            'fr_clothing': e['fr_clothing'],
            'fall_protection': e['fall_protection'],
            'hearing_protection': e['hearing_protection'],
            'respirator': e['respirator'],
            'other_safety_equipment': e['other_safety_equipment'],
            'other_safety_equipment_name': e['other_safety_equipment_name'],
            'fail_potential': e['fail_potential'],
            'overhead_lift': e['overhead_lift'],
            'h2s': e['h2s'],
            'pinch_points': e['pinch_points'],
            'slip_trip': e['slip_trip'],
            'sharp_objects': e['sharp_objects'],
            'power_tools': e['power_tools'],
            'hot_cold_surface': e['hot_cold_surface'],
            'pressure': e['pressure'],
            'dropped_objects': e['dropped_objects'],
            'heavy_lifting': e['heavy_lifting'],
            'weather': e['weather'],
            'flammables': e['flammables'],
            'chemicals': e['chemicals'],
            'other_hazards': e['other_hazards'],
            'other_hazards_name': e['other_hazards_name'],
            'confined_spaces_permits': e['confined_spaces_permits'],
            'hot_work_permit': e['hot_work_permit'],
            'excavation_trenching': e['excavation_trenching'],
            'one_call': e['one_call'],
            'one_call_num': e['one_call_num'],
            'lock_out_tag_out': e['lock_out_tag_out'],
            'fire_extinguisher': e['fire_extinguisher'],
            'inspection_of_equipment': e['inspection_of_equipment'],
            'msds_review': e['msds_review'],
            'ladder': e['ladder'],
            'permits': e['permits'],
            'other_check_review': e['other_check_review'],
            'other_check_review_name': e['other_check_review_name'],
            'weather_condition': e['weather_condition'],
            'weather_condition_description': e['weather_condition_description'],
            'wind_direction': e['wind_direction'],
            'wind_direction_description': e['wind_direction_description'],
            'task': e['task'],
            'muster_points': e['muster_points'],
            'recommended_actions_and_procedures':
                e['recommended_actions_and_procedures'],
            'signature1': e['signature1'],
            'signature2': e['signature2'],
            'signature3': e['signature3'],
            'coords': e['coords'],
            'location': e['location'],
          });
        }).toList();
      } else {
        listJsas = [];
      }

      return listJsas;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  uploadJSASToServer() async {
    try {
      final String urlApi = '${api.api}/${api.createJSAs}';
      final db = await DataBaseSQLite.db;
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      List<Map<String, dynamic>> listShift = await getJSAsSQL();

      if (listShift.isNotEmpty) {
        print('JSAS SQL => ${listShift[0]}');

        int count = 0;
        for (var data in listShift) {
          Map body = {
            'customer_id': data['customer_id'],
            'project_id': data['project_id'],
            'date': data['date'],
            'hazard': data['hazard'],
            'controls': data['controls'],
            'worker_id': data['worker_id'], //this references to pusher id
            'job_description': data['job_description'],
            'company': data['company'],
            'gps': data['gps'],
            'helper': data['helper'],
            'helper2_id': data['helper2_id'],
            //'other_worker_id':other.text.trim(),
            'steel_toad_shoes': data['steel_toad_shoes'],
            'hard_hat': data['hard_hat'],
            'safety_glasses': data['safety_glasses'],
            'h2s_monitor': data['h2s_monitor'],
            'fr_clothing': data['fr_clothing'],
            'fall_protection': data['fall_protection'],
            'hearing_protection': data['hearing_protection'],
            'respirator': data['respirator'],
            'other_safety_equipment': data['other_safety_equipment'],
            'other_safety_equipment_name': data['other_safety_equipment_name'],
            'fail_potential': data['fail_potential'],
            'overhead_lift': data['overhead_lift'],
            'h2s': data['h2s'],
            'pinch_points': data['pinch_points'],
            'slip_trip': data['slip_trip'],
            'sharp_objects': data['sharp_objects'],
            'power_tools': data['power_tools'],
            'hot_cold_surface': data['hot_cold_surface'],
            'pressure': data['pressure'],
            'dropped_objects': data['dropped_objects'],
            'heavy_lifting': data['heavy_lifting'],
            'weather': data['weather'],
            'flammables': data['flammables'],
            'chemicals': data['chemicals'],
            'other_hazards': data['other_hazards'],
            'other_hazards_name': data['other_hazards_name'],
            'confined_spaces_permits': data['confined_spaces_permits'],
            'hot_work_permit': data['hot_work_permit'],
            'excavation_trenching': data['excavation_trenching'],
            'one_call': data['one_call'],
            'one_call_num': data['one_call_num'],
            'lock_out_tag_out': data['lock_out_tag_out'],
            'fire_extinguisher': data['fire_extinguisher'],
            'inspection_of_equipment': data['inspection_of_equipment'],
            'msds_review': data['msds_review'],
            'ladder': data['ladder'],
            'permits': data['permits'],
            'other_check_review': data['other_check_review'],
            'other_check_review_name': data['other_check_review_name'],
            'weather_condition': data['weather_condition'],
            'weather_condition_description':
                data['weather_condition_description'],
            'wind_direction': data['wind_direction'],
            'wind_direction_description': data['wind_direction_description'],
            'task': data['task'],
            'muster_points': data['muster_points'],
            'recommended_actions_and_procedures':
                data['recommended_actions_and_procedures'],
            'signature1': data['signature1'],
            'signature2': data['signature2'],
            'signature3': data['signature3'],
            'coords': data['coords'],
            'location': data['location'],
          };
          final response = await http.post(Uri.parse(urlApi),
              headers: header, body: json.encode(body));
          Map<String, dynamic> decodeResp = json.decode(response.body);
          if (response.statusCode == 200 && decodeResp['success'] == true) {
            count++;
          } else {
            print('Not upload JSAs');
          }
        }
        // Map value = await uploadAllPhotosTickets(body);
        // print(value);
        if (count == listShift.length) {
          print('All JSAS has been upload success');
          await trucateJSAS();
        } else {
          print('Error All JSAS has  not been upload');
        }
        //await trucateSHift();
      }
    } catch (e) {
      print(e.toString());
      print('Error to upload all JSASs');
      // Get.snackbar('warinig', 'Please try it later, we not found information to upload.',
      //     colorText: Colors.black,
      //     backgroundColor: Colors.yellow,
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  //TRUNCATE TALBLE equipment
  trucateJSAS() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('jsas');
      print('jsas droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
