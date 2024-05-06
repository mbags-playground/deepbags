import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  static Future<Isar> getIsarInstance() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      schemas: [],
      directory: dir.path,
    );
    return isar;
  }
}
