import 'package:onax_app/src/repositories/models/equipmentModel.dart';
import 'package:onax_app/src/repositories/models/workersModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class WorkersSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(WorkerModel worker) async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO workers (  id ,name ,email ,language ,status ,type )"
          "VALUES (?,?,?,?,?,?)",
          [
            worker.id,
            worker.name,
            worker.email,
            worker.language,
            worker.status,
            worker.type,
          ]);
      print('workers inserted => $res => ${worker.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getWorkersSQL() async {
    try {
      List<WorkerModel> listWorkers = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.rawQuery("SELECT id, name FROM workers");

      listWorkers = res!.isNotEmpty
          ? res.map((e) => WorkerModel.fromJson(e)).toList()
          : [];
      Map result = {
        'statusCode': 200,
        'success': true,
        'data': listWorkers,
      };
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateWorkers() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('workers');
      print('workers droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
