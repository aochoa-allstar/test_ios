import 'package:intl/intl.dart';
import 'package:onax_app/src/repositories/models/customerModel.dart';
import 'package:onax_app/src/repositories/models/projectModel.dart';
import 'package:onax_app/src/services/sqlite/sqlite_db.dart';

import '../../repositories/models/desty_origin_Model.dart';

class ProjectsSQL {
  DataBaseSQLite con = DataBaseSQLite();

  //download info.
  insert(ProjectModel project) async {
    try {
      // late DateTime date = project.initialDate != null
      //     ? DateTime.parse(project.initialDate)
      //     : DateTime.now();
      // String formatDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
      final db = await DataBaseSQLite.db;
      var res = await db?.rawInsert(
          "INSERT INTO project (id,customer_id,name,initial_date)"
          "VALUES (?,?,?,?)",
          [
            project.id,
            project.customerId,
            project.name,
            '',
          ]);
      print('projects inserted => $res => ${project.id}');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

  //get allEquipment
  getProjectsSQL(int costumer) async {
    try {
      List<ProjectModel> listProjects = [];
      final db = await DataBaseSQLite.db;
      var res = await db
          ?.query("project", where: "customer_id = ?", whereArgs: [costumer]);

      listProjects = res!.isNotEmpty
          ? res.map((e) => ProjectModel.fromJson(e)).toList()
          : [];
      Map<String, dynamic> result;
      if (listProjects.isNotEmpty) {
        result = {'statusCode': 200, 'success': true, 'data': listProjects};
      } else {
        result = {'statusCode': 200, 'success': false, 'data': listProjects};
      }
      print(listProjects);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  getALLProjectsSQL() async {
    try {
      List<ProjectModel> listProjects = [];
      final db = await DataBaseSQLite.db;
      var res = await db?.query("project");

      listProjects = res!.isNotEmpty
          ? res.map((e) => ProjectModel.fromJson(e)).toList()
          : [];
      Map<String, dynamic> result;
      if (listProjects.isNotEmpty) {
        result = {'statusCode': 200, 'success': true, 'data': listProjects};
      } else {
        result = {'statusCode': 200, 'success': false, 'data': listProjects};
      }
      print(listProjects);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  //TRUNCATE TALBLE equipment
  trucateProjects() async {
    try {
      final db = await DataBaseSQLite.db;
      var res = await db?.delete('project');
      print('project droped');
      return res;
    } catch (e) {
      print(e.toString());
    }
  }
}
