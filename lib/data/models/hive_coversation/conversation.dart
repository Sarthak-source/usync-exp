import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_default_conversation/default_conversation_preferences.dart';
import 'package:usync/data/models/hive_messages/message.dart';
import 'package:usync/data/models/hive_user/user.dart';
part 'conversation.g.dart';

@HiveType(typeId: 0)
class Conversation extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int? user_id;

  @HiveField(3)
  String? last_message_id;

  @HiveField(4)
  List<Message>? messages;

  @HiveField(5)
  List<String>? user_ids;

  @HiveField(6)
  List<User> users;

  @HiveField(7)
  Message? lastMessage;

  @HiveField(8)
  DateTime? created_at;

  @HiveField(9)
  DateTime? updated_at;

  @HiveField(10)
  String? type;

  @HiveField(11)
  DefaultConversationPreferences? preferences;

  @HiveField(12)
  int unseen_messages_count;

  Conversation({
    this.id,
    this.name = '',
    this.user_id,
    this.last_message_id,
    this.messages = const [],
    this.user_ids,
    this.users = const [],
    this.lastMessage,
    this.created_at,
    this.updated_at,
    this.type,
    this.preferences,
    this.unseen_messages_count = 0,
  });
}
