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
  int? from_system = 0;

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
  List<dynamic>? file_ids;

  @HiveField(12)
  List<File>? files;

  @HiveField(13)
  Geolocation? geolocation;

  @HiveField(14)
  String? created_at;

  @HiveField(15)
  String? updated_at;

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

Message mapJsonToMessage(Map<String, dynamic> json, User user,Conversation conversation) {
  return Message(
    id: json['id'] as String?,
    type: json['type'] as String? ?? '',
    from_system: json['from_system'] as int? ?? 0,
    conversation_id: json['conversation_id'] as String? ?? '',
    conversation: conversation,
    user_id: json['user_id'] as int?,
    user: user,
    content: json['content'] as String? ?? '',
    attachable_type: json['attachable_type'] as String?,
    attachable_id: json['attachable_id'] as int?,
    attachable: json['attachable'],
    file_ids: json['file_ids'] ,
    // files: json['files'] != null
    //     ? List<File>.from(json['files'].map((f) => File.fromJson(f)))
    //     : null,
    // geolocation: json['geolocation'] != null
    //     ? Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>)
    //     : null,
    created_at: json['created_at'] as String?,
    updated_at: json['updated'] as String?,
  );}
