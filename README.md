# artikel tahapan pemrograman

## Tahapan Pemrograman

### 1. Setup Isar

#### 1.1 Menambahkan Dependensi Isar
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
Kemudian saya jalankan perintah berikut di terminal untuk menginstal paket yang dibutuhkan:

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


