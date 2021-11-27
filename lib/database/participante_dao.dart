import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';
import 'package:sqflite/sqflite.dart';

import 'app_database.dart';

class ParticipanteDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numero TEXT)';
  static const String _tableName = 'participante';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numero = 'numero';

  Future<int> save(Participante participante) async {
    final Database db = await getDatabase();
    Map<String, dynamic> participanteMap = _toMap(participante);
    return db.insert(_tableName, participanteMap);
  }

  void editar(Participante participante) async {
    final Database db = await getDatabase();
    Map<String, dynamic> participanteMap = _toMap(participante);
    await db.update(_tableName, participanteMap,
        where: "id = ?", whereArgs: [participante.id]);
  }

  Future<List<Participante>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Participante> participantes = _toList(result);
    return participantes;
  }

  Future<Participante> find(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM $_tableName where id=$id');
    List<Participante> participantes = _toList(result);
    return participantes.removeLast();
  }

  Map<String, dynamic> _toMap(Participante participante) {
    final Map<String, dynamic> participanteMap = Map();
    participanteMap[_nome] = participante.nome;
    participanteMap[_numero] = participante.numero;
    return participanteMap;
  }

  List<Participante> _toList(List<Map<String, dynamic>> result) {
    final List<Participante> participantes = []..length = result.length;
    for (Map<String, dynamic> row in result) {
      var id = int.parse([_id].toString());
      var nome = row[_nome].toString();
      var numero = row[_numero].toString();
      var participante = Participante(id, '', nome, numero, '', []);
      participantes.add(participante);
    }
    return participantes;
  }

  Future<void> deleteParticipante(Participante participante) async {
    final Database db = await getDatabase();
    int id = participante.id;
    await db.rawQuery('DELETE FROM $_tableName where id=$id');
  }

  void deleteAll() async {
    final Database db = await getDatabase();
    db.delete(_tableName);
  }
}
