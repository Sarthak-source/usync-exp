import 'package:hive/hive.dart';
import 'package:usync/data/models/hive_language/language.dart';
import 'package:usync/data/models/hive_user/user.dart';
part 'account.g.dart';

@HiveType(typeId: 7)
class Account {
  @HiveField(0)
  String? status;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? middleName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? lastName;
  @HiveField(6)
  Language? language;
  @HiveField(7)
  dynamic timezone;
  @HiveField(8)
  String? lastLoginAt;
  @HiveField(9)
  int? doNotDisturb;
  @HiveField(10)
  dynamic locationDetail;
  @HiveField(11)
  bool? isNewUser;
  @HiveField(12)
  String? phone;
  @HiveField(13)
  String? location;
  @HiveField(14)
  String? birthdateAt;
  @HiveField(15)
  String? type;
  @HiveField(16)
  User? activeUser;
  @HiveField(17)
  User? communityUser;
  @HiveField(18)
  List<User>? users;
  @HiveField(19)
  dynamic communities;
  @HiveField(20)
  String? id;

  Account({
    this.status,
    this.firstName,
    this.middleName,
    this.email,
    this.gender,
    this.lastName,
    this.language,
    this.timezone,
    this.lastLoginAt,
    this.doNotDisturb,
    this.locationDetail,
    this.isNewUser,
    this.phone,
    this.location,
    this.birthdateAt,
    this.type,
    this.activeUser,
    this.communityUser,
    this.users,
    this.communities,
    this.id,
  });
}
