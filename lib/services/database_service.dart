import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firstproject/models/property.dart' as propertyModel;

class DatabaseService {

    static late final Isar db;

    static Future<void> setup() async {
      final dir = await getApplicationDocumentsDirectory();
      db = await Isar.open(
        [propertyModel.MyPropertySchema],
        directory: dir.path,
      );
    }

    static Future<void> addProperty(propertyModel.MyProperty property) async {
      property.creationDateTime = DateTime.now();
      property.updateDateTime = DateTime.now();
      await db.writeTxn(() async => await db.myPropertys.put(property));
    }

    static Future<List<propertyModel.MyProperty>> getProperties() async {
      return await db.myPropertys.where().findAll();
    }

    static Future<void> deleteProperty(int id) async {
      await db.writeTxn(() async => await db.myPropertys.delete(id));
    }

    static Future<void> updateProperty(propertyModel.MyProperty property) async {
      property.updateDateTime = DateTime.now();
      await db.writeTxn(() async => await db.myPropertys.put(property));
    }
}
