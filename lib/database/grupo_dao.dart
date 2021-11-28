import 'dart:convert';

import 'package:sorteio_amigo_secreto_whatsapp/model/grupo.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database.dart';

class GrupoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_participantes TEXT)';
  static const String _tableName = 'grupo';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _participantes = 'participantes';

  Future<int> save(Grupo grupo) async {
    final Database db = await getDatabase();
    Map<String, dynamic> grupoMap = _toMap(grupo);
    return db.insert(_tableName, grupoMap);
  }

  void editar(Grupo grupo) async {
    final Database db = await getDatabase();
    Map<String, dynamic> grupoMap = _toMap(grupo);
    await db
        .update(_tableName, grupoMap, where: "id = ?", whereArgs: [grupo.id]);
  }

  Future<List<Grupo>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Grupo> grupos = _toList(result);
    return grupos;
  }

  Future<Grupo> find(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM $_tableName where id=$id');
    List<Grupo> grupos = _toList(result);
    return grupos.removeLast();
  }

  Map<String, dynamic> _toMap(Grupo grupo) {
    final Map<String, dynamic> grupoMap = Map();
    grupoMap[_nome] = grupo.nome;
    var encodedList = grupo.participantes.map((e) => jsonEncode(e.toJson())).toList();
    grupoMap[_participantes] = jsonEncode(encodedList);
    return grupoMap;
  }

  List<Grupo> _toList(List<Map<String, dynamic>> result) {
    final List<Grupo> grupos = [];
    for (Map<String, dynamic> row in result) {
      var id = row[_id];
      var nome = row[_nome];
      List<dynamic> listDynamic = jsonDecode(row[_participantes]);
      var participantes = listDynamic.map((e) => Participante.fromJson(jsonDecode(e))).toList();
      var grupo = Grupo(id, nome, participantes);
      grupos.add(grupo);
    }
    return grupos;
  }

  Future<void> deleteGrupo(Grupo grupo) async {
    final Database db = await getDatabase();
    int id = grupo.id;
    await db.rawQuery('DELETE FROM $_tableName where id=$id');
  }

  void deleteAll() async {
    final Database db = await getDatabase();
    db.delete(_tableName);
  }
}
