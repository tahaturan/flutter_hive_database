// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names
import 'package:hive_flutter/hive_flutter.dart';

part 'ogrenci.g.dart';

@HiveType(typeId: 1)
class Ogrenci {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String isim;

  @HiveField(2)
  final Enum gozRengi;

  Ogrenci(this.id, this.isim, this.gozRengi);

  @override
  String toString() => 'id: $id, isim: $isim, gozRengi: $gozRengi';
}

@HiveType(typeId: 2)
enum GozRenk {
  @HiveField(0, defaultValue: true)
  SIYAH,

  @HiveField(1)
  MAVI,

  @HiveField(2)
  YESIL
}
