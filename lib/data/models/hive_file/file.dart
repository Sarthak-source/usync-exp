import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_pages/page.dart';
import 'package:usync/data/models/hive_user/user.dart';

part 'file.g.dart';

@HiveType(typeId: 2)
class File extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type_;

  @HiveField(2)
  String type;

  @HiveField(3)
  String name;

  @HiveField(4)
  String description;

  @HiveField(5)
  String description_summary;

  @HiveField(6)
  String poster_id;

  @HiveField(7)
  File? cover;

  @HiveField(8)
  String original_extension;

  @HiveField(9)
  int playable_length;

  @HiveField(10)
  Map<String, dynamic>? data;

  @HiveField(11)
  int user_id;

  @HiveField(12)
  User? user;

  @HiveField(13)
  String page_id;

  @HiveField(14)
  Page? page;

  @HiveField(15)
  String aspect_ratio;

  @HiveField(22)
  Map<String, dynamic>? links;

  @HiveField(17)
  Map<String, dynamic>? timestamps;

  @HiveField(18)
  bool manageable;

  @HiveField(19)
  bool meta;

  @HiveField(20)
  bool marked_as_nsfw;

  @HiveField(21)
  String m3u8_path;

  File({
    this.id = "",
    this.type_ = "",
    this.type = "",
    this.name = "",
    this.description = "",
    this.description_summary = "",
    this.poster_id = "",
    this.cover,
    this.original_extension = "",
    this.playable_length = 0,
    this.data,
    this.user_id = 0,
    this.user,
    this.page_id = "",
    this.page,
    this.aspect_ratio = "",
    this.links = const {
      'source': '',
      'poster': '',
      'xxs': '',
      'xs': '',
      'sm': '',
      'md': '',
      'lg': '',
      'xl': '',
      'xxl': ''
    },
    this.timestamps,
    this.manageable = false,
    this.meta = false,
    this.marked_as_nsfw = false,
    this.m3u8_path = "",
  });
}

File mapJsonToFile(Map<String, dynamic> json) {
  return File(
    id: json['id'] ?? "",
    type_: json['_type'] ?? "",
    type: json['type'] ?? "",
    name: json['name']['full'] ?? "",
    description: json['description'] ?? "",
    description_summary: json['description_summary'] ?? "",
    poster_id: json['poster_id'] ?? "",
    cover: json['cover'],
    original_extension: json['original_extension'] ?? "",
    playable_length: json['playable_length'] ?? 0,
    data: json['data'] ?? {},
    user_id: json['user_id'] ?? 0,
    //user: json['user'],
    page_id: json['page_id'] ?? "",
    //page: json['page'],
    aspect_ratio: json['aspect_ratio'] ?? "",
    links: json['avatar'] != null ? json['avatar']['links'] ?? {} : {},
    timestamps: json['timestamps'] ?? {},
    manageable: json['manageable'] ?? false,
    //meta: json['meta'] ?? false,
    marked_as_nsfw: json['marked_as_nsfw'] ?? false,
    m3u8_path: json['m3u8_path'] ?? "",
  );
}
