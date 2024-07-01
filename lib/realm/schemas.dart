import 'package:realm/realm.dart';

part 'schemas.realm.dart';

@RealmModel()
class _Lang {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  @MapTo('owner_id')
  late String ownerId;
  bool isDone = false;
  late String lanCode;
  late String key;
  late String content;
}
