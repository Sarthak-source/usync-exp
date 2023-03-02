import 'package:hive/hive.dart';

part 'default_conversation_preferences.g.dart';

@HiveType(typeId: 0)
class DefaultConversationPreferences {
  @HiveField(0)
  bool doNotDisturb;

  @HiveField(1)
  DateTime? deletedAt;

  @HiveField(2)
  String deletedByUserId;

  DefaultConversationPreferences({
    this.doNotDisturb = false,
    this.deletedAt,
    this.deletedByUserId = '',
  });
}
