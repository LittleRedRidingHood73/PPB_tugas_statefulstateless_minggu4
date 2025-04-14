import 'package:isar/isar.dart';
import 'enums.dart';

part 'property.g.dart';

@Collection()

class MyProperty {
  Id id = Isar.autoIncrement;

  String? title;
  String? address;
  late int price;
  String? image;

  @enumerated
  Status status = Status.available;

  DateTime creationDateTime = DateTime.now();
  DateTime updateDateTime = DateTime.now();
}