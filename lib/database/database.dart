

import 'package:flutter_app_offline/model/invite.dart';
import 'package:sqflite/sqflite.dart';

class DB {


static Database _db;

  static int get _version => 1;

  static final String TABLE_NAME = "Task";


  static final String TABLE_ROW_ID = "id";
  static final String TABLE_ROW_TASKNAME = "taskName";
  static final String TABLE_ROW_GUEST_NUM = "guestNum";
  static final String TABLE_ROW_GUEST_ADDRESS = "guestAddress";
  static final String TABLE_ROW_VISTING_STATUS = "visitingStatus";
  static final String TABLE_ROW_ISCOMPLETE = "isComplete";


  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'todo';

      print(_path);

      _db = await openDatabase(_path, version: _version, onCreate: onCreate);

      print('sucessfully data base is added');
    }

    catch (e) {
      print('Something went wrong');
    }
  }


  static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE $TABLE_NAME("
        "$TABLE_ROW_ID INTEGER PRIMARY KEY,"
        "$TABLE_ROW_TASKNAME TEXT,"
    "$TABLE_ROW_GUEST_NUM TEXT,"
        "$TABLE_ROW_GUEST_ADDRESS TEXT,"
        "$TABLE_ROW_VISTING_STATUS TEXT,"

        "$TABLE_ROW_ISCOMPLETE TEXT"
        ")");
  }


  static Future<int> insert(INVITE task) async {
    var table = await _db.rawQuery(
        "SELECT MAX(id)+1 as $TABLE_ROW_ID FROM $TABLE_NAME");
    int id = table.first["$TABLE_ROW_ID"];

    print(id);

    var raw = await _db.rawInsert(
        "INSERT Into $TABLE_NAME ($TABLE_ROW_ID, $TABLE_ROW_TASKNAME,$TABLE_ROW_GUEST_NUM,$TABLE_ROW_GUEST_ADDRESS,$TABLE_ROW_VISTING_STATUS, $TABLE_ROW_ISCOMPLETE) "
            "VALUES (?,?,?,?,?,?)",
        [id, task.name,task.num,task.address,task.status, task.isComplete == true ? "true" : "false"]
    );

    return raw;
  }


  static Future<List<INVITE>> getInvitations() async {
    var res = await _db.query("$TABLE_NAME");

    List<INVITE> todos = [];
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        todos.add(INVITE(

          id: res[i]["$TABLE_ROW_ID"],
          name: res[i]["$TABLE_ROW_TASKNAME"],
          num: res[i]["$TABLE_ROW_GUEST_NUM"],
          address: res[i]["$TABLE_ROW_GUEST_ADDRESS"],
          status: res[i]["$TABLE_ROW_VISTING_STATUS"],

          isComplete: res[i]["$TABLE_ROW_ISCOMPLETE"] == "true" ? true : false,

        ));
      }

      return todos;
    }

    else {
      print("no Data");
    }
  }


  static Future<int> update(INVITE task) async {
    var result = await _db.update(
        TABLE_NAME, task.toMap(), where: '$TABLE_ROW_ID = ?',
        whereArgs: [task.id]);
    return result;
  }


  static Future<int> delete(int id) async {
    var result = await _db.delete(
        TABLE_NAME, where: '$TABLE_ROW_ID = ?', whereArgs: [id]);

    return result;
  }

}