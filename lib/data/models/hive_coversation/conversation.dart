// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_default_conversation/default_conversation_preferences.dart';
import 'package:usync/data/models/hive_messages/message.dart';
import 'package:usync/data/models/hive_user/user.dart';
part 'conversation.g.dart';

@HiveType(typeId: 0)
class Conversation extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? user_id;

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
  String? created_at;

  @HiveField(9)
  String? updated_at;

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

Conversation mapJsonToConversation(
  Map<String, dynamic> json,
  List<User> userList,
  Message? lastMessage,
  List<Message>? messages,
) {
  return Conversation(
    id: json['id'],
    type: json['type'],
    name: json['name'] ?? '',
    user_id: json['user_id'],
    created_at: json['created_at'],
    updated_at: json['updated_at'],
    last_message_id: json['last_message_id'],
    messages: messages,
    user_ids:json['user_ids'],
    users: userList,
    lastMessage: lastMessage,
    // preferences: json['preferences'],
    unseen_messages_count: json['unseen_messages_count'] ?? 0,
  );
}
