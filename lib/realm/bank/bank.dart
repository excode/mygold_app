import 'package:mygold/utils/apiResponse.dart';
import 'package:realm/realm.dart';

part 'bank.g.dart';

@RealmModel()
@MapTo('Banks')
class _Banks extends BaseModel {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('__v')
  int? v;

  String? accountname;

  String? accountnumber;

  int? accounttype;

  bool? active;

  String? address;

  String? bankname;

  String? branchname;

  String? country;

  DateTime? createat;

  String? createby;

  String? postcode;

  String? swfitcode;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    //throw UnimplementedError();
    return {"id": 1};
  }
}
