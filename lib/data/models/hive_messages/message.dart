import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_coversation/conversation.dart';
import 'package:usync/data/models/hive_file/file.dart';
import 'package:usync/data/models/hive_location/geolocation.dart';
import 'package:usync/data/models/hive_user/user.dart';
part 'message.g.dart';

@HiveType(typeId: 4)
class Message extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? type = '';

  @HiveField(2)
  String? from_system = '';

  @HiveField(3)
  String? conversation_id = '';

  @HiveField(4)
  Conversation? conversation;

  @HiveField(5)
  int? user_id;

  @HiveField(6)
  User? user;

  @HiveField(7)
  String? content = '';

  @HiveField(8)
  String? attachable_type;

  @HiveField(9)
  int? attachable_id;

  @HiveField(10)
  HiveObject? attachable;

  @HiveField(11)
  List<int>? file_ids;

  @HiveField(12)
  List<File>? files;

  @HiveField(13)
  Geolocation? geolocation;

  @HiveField(14)
  DateTime? created_at;

  @HiveField(15)
  DateTime? updated_at;

  Message({
    this.id,
    this.type,
    this.from_system,
    this.conversation_id,
    this.conversation,
    this.user_id,
    this.user,
    this.content,
    this.attachable_type,
    this.attachable_id,
    this.attachable,
    this.file_ids,
    this.files,
    this.geolocation,
    this.created_at,
    this.updated_at,
  });
}
