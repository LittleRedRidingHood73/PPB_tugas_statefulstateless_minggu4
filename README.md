# artikel tahapan pemrograman
Nama: Fauzan Dzikri Rabbani
NRP: 5025221311

## Tahapan Pemrograman

### 1. Setup Isar

Langkah pertama adalah menambahkan dependensi Isar. Saya menambahkan dependensi berikut:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5

  dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  isar_generator: ^3.1.0+1
  build_runner: any
```
Kemudian saya menjalankan perintah berikut di terminal untuk menginstal paket yang dibutuhkan:

```bash
flutter pub get
```

### 2. Membuat Model
Langkah selanjutnya adalah membuat model untuk data saya:

```dart
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
```

Kemudian saya menjalankan perintah berikut untuk melakukan build terhadap database isar:

```bash
flutter pub run build_runner build
```

Dari situ terbentuklah 'property.g.dart'

### 3. Membuat Fungsi-fungsi Helper untuk Interface ke Database Isar

Selanjutnya saya membuat 'database_service.dart' sebagai berikut untuk membantu setup, add, edit, dan delete ke database:

```dart
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

```

### 4. Implementasi Database Isar ke Aplikasi di 'main.dart'

#### 4.0. Mengubah 'initState()' dan Menambahkan '_loadProperties()'

ditambahkan fungsi baru '_loadProperties()' yang akan mengambil semua data dari database dan mengubah isi List<MyProperty> sesuai dengan data baru yang diambil. '_loadProperties()' dilakukan pada inisialisasi page dan pada setiap penambahan, edit, dan delete data

```dart
void initState() {
    super.initState();
    _loadProperties();
  }

  void _loadProperties() async {
    final list = await DatabaseService.getProperties(); // from your DB service
    setState(() {
      properties = list;
    });
  }
```

#### 4.1. Mengubah yaang Sebelumnya List<Property> menjadi List<MyProperty>

Dilakukan agar yang sebelumnya class biasa menjadi class dengan format Collection Isar:

```dart
List<MyProperty> properties = [];
```

#### 4.2. Mengubah Fungsi '_addProperty()'

Fungsi ini diubah pada bagian setState() menjadi:

```dart
await DatabaseService.addProperty(MyProperty()
                    ..title = titleController.text
                    ..address = addressController.text
                    ..price = int.tryParse(priceController.text) ?? 0
                    ..image = imageController.text);
                  titleController.text = '';
                  addressController.text = '';
                  priceController.text = '';
                  imageController.text = '';
                  Navigator.pop(context);
                  _loadProperties();
```

agar penambahan baru langsung dilakukan ke database

#### 4.3. Mengubah fungsi '_editProperty()'

Fungsi ini diubah pada bagian setState() menjadi:

```dart
MyProperty prop = properties[index];
                prop
                  ..title = title
                  ..address = address
                  ..price = price
                  ..image = image
                  ..updateDateTime = DateTime.now();

                await DatabaseService.updateProperty(prop);
                Navigator.pop(context);
                _loadProperties();
```

agar data pada database diubah secara langsung

#### 4.4. Mengubah fungsi 'delete()'

yang sebelumnya kita lakukan hanyalah menghapus data tersebut dari list, sekarang langsung menghapus data dari database:

```dart
await DatabaseService.deleteProperty(properties[index].id);
                  _loadProperties();
````
