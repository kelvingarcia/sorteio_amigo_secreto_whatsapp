import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'participante_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'sorteio.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ParticipanteDao.tableSql);
    },
    version: 1,
  );
}
