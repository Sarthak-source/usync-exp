// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_file/file.dart';
part 'page.g.dart';

@HiveType(typeId: 5)
class Page extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? type;

  @HiveField(2)
  Map<String, String>? name;

  @HiveField(3)
  dynamic account;

  @HiveField(4)
  String? avatar_id;

  @HiveField(5)
  File? avatar;

  @HiveField(6)
  String? cover_id;

  @HiveField(7)
  File? cover;

  @HiveField(8)
  dynamic avatar_data;

  @HiveField(9)
  dynamic cover_data;

  @HiveField(10)
  String? sub_title;

  @HiveField(11)
  dynamic description;

  @HiveField(12)
  dynamic description_summary;

  @HiveField(13)
  bool isFirstView;

  @HiveField(14)
  Map<String, dynamic> settings;

  @HiveField(15)
  String? pagename;

  Page({
    this.id,
    this.type,
    this.name = const {'first': '', 'full': ''},
    this.account,
    this.avatar_id,
    this.avatar,
    this.cover_id,
    this.cover,
    this.avatar_data,
    this.cover_data,
    this.sub_title,
    this.description,
    this.description_summary,
    this.isFirstView = false,
    this.settings = const {},
    this.pagename,
  });
}
