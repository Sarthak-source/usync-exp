// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_file/file.dart';
part 'user.g.dart';

@HiveType(typeId: 6)
class User extends HiveObject {
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
  String? settings;

  @HiveField(15)
  String? username;

  @HiveField(16)
  Map<String, dynamic> preferences;

  User({
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
    this.settings = '',
    this.username,
    this.preferences = const {},
  });

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! User) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}


User mapJsonToUser(Map<String, dynamic> json,File? avatar,File? cover) {
    return User(
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] != null
          ? Map<String, String>.from(json['name'] as Map)
          : null,
      account: json['account'],
      avatar_id: json['avatar_id'] as String?,
      avatar: avatar,
      cover_id: json['cover_id'] as String?,
      cover: cover,
      avatar_data: json['avatar_data'],
      cover_data: json['cover_data'],
      sub_title: json['sub_title'] as String?,
      description: json['description'],
      description_summary: json['description_summary'],
      isFirstView: json['isFirstView'] as bool? ?? false,
      settings: json['settings'] as String?,
      username: json['username'] as String?,
      preferences: json['preferences'] != null
          ? Map<String, dynamic>.from(json['preferences'] as Map)
          : {},
    );
  }