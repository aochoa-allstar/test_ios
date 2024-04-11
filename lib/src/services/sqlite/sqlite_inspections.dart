import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/inspectionsModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';

import '../../repositories/models/desty_origin_Model.dart';
import '../../utils/urlApi/globalApi.dart';
import 'package:http/http.dart' as http;

class InspectionsSQL {
  DataBaseSQLite con = DataBaseSQLite();
  final GlobalApi api = GlobalApi();
  //download info.
  insertJSAsSQL(Map data) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO inspections ( date , location , equipment_id , odometer_begin , odometer_end , remarks , worker_id , vehicle_condition  , defects_corrected  , defects_not_corrected  , trailer_1_equipment_id , trailer_2_equipment_id , v_condition_signature , driver_signature , checkBoxItems )"
          "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
          [
            data['date'],
            data['location'],
            data['equipment_id'],
            data['odometer_begin'],
            data['odometer_end'],
            data['remarks'],
            data['worker_id'],
            data['vehicle_condition'],
            data['defects_corrected'],
            data['defects_not_corrected'],
            data['trailer_1_equipment_id'],
            data['trailer_2_equipment_id'],
            data['v_condition_signature'],
            data['driver_signature'],
            data['checkBoxItems'],
          ]);
      print('inspections inserted => $res => ${res}');
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': {'inspectionID': res},
      };
      return result;
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  //get allEquipment
  getInspectionsSQL() async {
    try {
      List<InspectionsModel> listInspections = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT * FROM inspections");

      listInspections = res!.isNotEmpty
          ? res.map((e) => InspectionsModel.fromJson(e)).toList()
          : [];
      return listInspections;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  uploadInspectionsToServer() async {
    try {
      Location locations = Location();
      final String urlApi = '${api.api}/${api.createInspection}';
      final db = await DataBaseSQLite.db;
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      List<InspectionsModel> listInspections = await getInspectionsSQL();

      if (listInspections.isNotEmpty) {
        print('INSPECTIONS SQL  => ${listInspections[0]}');

        int count = 0;
        for (var data in listInspections) {
          LocationData coordenates = await locations.getLocation();
          String sendCoords =
              '${coordenates.latitude}, ${coordenates.longitude}';
          Map body = {
            'date': data.date,
            'location': data.location.isNotEmpty ? data.location : sendCoords,
            'equipment_id': data.equipment_id,
            'odometer_begin': data.odometer_begin,
            'odometer_end': data.odometer_end,
            'remarks': data.remarks,
            'worker_id': data.worker_id,
            'vehicle_condition': data.vehicle_condition,
            'defects_corrected': data.defects_corrected,
            'defects_not_corrected': data.defects_not_corrected,
            'trailer_1_equipment_id': data.trailer_1_equipment_id,
            'trailer_2_equipment_id': data.trailer_2_equipment_id,
            'v_condition_signature': data.v_condition_signature,
            'driver_signature': data.driver_signature,
            'checkBoxItems': data.checkBoxItems,
          };
          final response = await http.post(Uri.parse(urlApi),
              headers: header, body: json.encode(body));
          Map<String, dynamic> decodeResp = json.decode(response.body);
          if (response.statusCode == 200 && decodeResp['success'] == true) {
            count++;
          } else {
            print('Not upload Inspections');
          }
        }

        // Map value = await uploadAllPhotosTickets(body);
        // print(value);
        if (count == listInspections.length) {
          print('All Inspections has been upload success');
          await trucateInspections();
        } else {
          print('Error All Inspections has been upload');
        }
        //await trucateSHift();
      }
    } catch (e) {
      print(e.toString());
      print('Error to upload all Inspectionss');
      // Get.snackbar('warinig', 'Please try it later, we not found information to upload.',
      //     colorText: Colors.black,
      //     backgroundColor: Colors.yellow,
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  //TRUNCATE TALBLE equipment
  trucateInspections() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('inspections');
      print('inspections droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
