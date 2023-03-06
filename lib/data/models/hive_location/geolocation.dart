import 'package:hive/hive.dart';
part 'geolocation.g.dart';

@HiveType(typeId: 3)
class Geolocation extends HiveObject {
  @HiveField(0)
  String latitude = '';

  @HiveField(1)
  String longitude = '';
}
