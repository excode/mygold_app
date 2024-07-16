// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Banks extends _Banks with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Banks(
    ObjectId id, {
    int? v,
    String? accountname,
    String? accountnumber,
    int? accounttype,
    bool? active,
    String? address,
    String? bankname,
    String? branchname,
    String? country,
    DateTime? createat,
    String? createby,
    String? postcode,
    String? swfitcode,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Banks>({
        'active': false,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, '__v', v);
    RealmObjectBase.set(this, 'accountname', accountname);
    RealmObjectBase.set(this, 'accountnumber', accountnumber);
    RealmObjectBase.set(this, 'accounttype', accounttype);
    RealmObjectBase.set(this, 'active', active);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'bankname', bankname);
    RealmObjectBase.set(this, 'branchname', branchname);
    RealmObjectBase.set(this, 'country', country);
    RealmObjectBase.set(this, 'createat', createat);
    RealmObjectBase.set(this, 'createby', createby);
    RealmObjectBase.set(this, 'postcode', postcode);
    RealmObjectBase.set(this, 'swfitcode', swfitcode);
  }

  Banks._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int? get v => RealmObjectBase.get<int>(this, '__v') as int?;
  @override
  set v(int? value) => RealmObjectBase.set(this, '__v', value);

  @override
  String? get accountname =>
      RealmObjectBase.get<String>(this, 'accountname') as String?;
  @override
  set accountname(String? value) =>
      RealmObjectBase.set(this, 'accountname', value);

  @override
  String? get accountnumber =>
      RealmObjectBase.get<String>(this, 'accountnumber') as String?;
  @override
  set accountnumber(String? value) =>
      RealmObjectBase.set(this, 'accountnumber', value);

  @override
  int? get accounttype => RealmObjectBase.get<int>(this, 'accounttype') as int?;
  @override
  set accounttype(int? value) =>
      RealmObjectBase.set(this, 'accounttype', value);

  @override
  bool? get active => RealmObjectBase.get<bool>(this, 'active') as bool?;
  @override
  set active(bool? value) => RealmObjectBase.set(this, 'active', value);

  @override
  String? get address =>
      RealmObjectBase.get<String>(this, 'address') as String?;
  @override
  set address(String? value) => RealmObjectBase.set(this, 'address', value);

  @override
  String? get bankname =>
      RealmObjectBase.get<String>(this, 'bankname') as String?;
  @override
  set bankname(String? value) => RealmObjectBase.set(this, 'bankname', value);

  @override
  String? get branchname =>
      RealmObjectBase.get<String>(this, 'branchname') as String?;
  @override
  set branchname(String? value) =>
      RealmObjectBase.set(this, 'branchname', value);

  @override
  String? get country =>
      RealmObjectBase.get<String>(this, 'country') as String?;
  @override
  set country(String? value) => RealmObjectBase.set(this, 'country', value);

  @override
  DateTime? get createat =>
      RealmObjectBase.get<DateTime>(this, 'createat') as DateTime?;
  @override
  set createat(DateTime? value) => RealmObjectBase.set(this, 'createat', value);

  @override
  String? get createby =>
      RealmObjectBase.get<String>(this, 'createby') as String?;
  @override
  set createby(String? value) => RealmObjectBase.set(this, 'createby', value);

  @override
  String? get postcode =>
      RealmObjectBase.get<String>(this, 'postcode') as String?;
  @override
  set postcode(String? value) => RealmObjectBase.set(this, 'postcode', value);

  @override
  String? get swfitcode =>
      RealmObjectBase.get<String>(this, 'swfitcode') as String?;
  @override
  set swfitcode(String? value) => RealmObjectBase.set(this, 'swfitcode', value);

  @override
  Stream<RealmObjectChanges<Banks>> get changes =>
      RealmObjectBase.getChanges<Banks>(this);

  @override
  Banks freeze() => RealmObjectBase.freezeObject<Banks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      '__v': v?.toEJson(),
      'accountname': accountname?.toEJson(),
      'accountnumber': accountnumber?.toEJson(),
      'accounttype': accounttype?.toEJson(),
      'active': active?.toEJson(),
      'address': address?.toEJson(),
      'bankname': bankname?.toEJson(),
      'branchname': branchname?.toEJson(),
      'country': country?.toEJson(),
      'createat': createat?.toEJson(),
      'createby': createby?.toEJson(),
      'postcode': postcode?.toEJson(),
      'swfitcode': swfitcode?.toEJson(),
    };
  }

  static EJsonValue _toEJson(Banks value) => value.toEJson();
  static Banks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        '__v': EJsonValue v,
        'accountname': EJsonValue accountname,
        'accountnumber': EJsonValue accountnumber,
        'accounttype': EJsonValue accounttype,
        'active': EJsonValue active,
        'address': EJsonValue address,
        'bankname': EJsonValue bankname,
        'branchname': EJsonValue branchname,
        'country': EJsonValue country,
        'createat': EJsonValue createat,
        'createby': EJsonValue createby,
        'postcode': EJsonValue postcode,
        'swfitcode': EJsonValue swfitcode,
      } =>
        Banks(
          fromEJson(id),
          v: fromEJson(v),
          accountname: fromEJson(accountname),
          accountnumber: fromEJson(accountnumber),
          accounttype: fromEJson(accounttype),
          active: fromEJson(active),
          address: fromEJson(address),
          bankname: fromEJson(bankname),
          branchname: fromEJson(branchname),
          country: fromEJson(country),
          createat: fromEJson(createat),
          createby: fromEJson(createby),
          postcode: fromEJson(postcode),
          swfitcode: fromEJson(swfitcode),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Banks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Banks, 'Banks', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('v', RealmPropertyType.int, mapTo: '__v', optional: true),
      SchemaProperty('accountname', RealmPropertyType.string, optional: true),
      SchemaProperty('accountnumber', RealmPropertyType.string, optional: true),
      SchemaProperty('accounttype', RealmPropertyType.int, optional: true),
      SchemaProperty('active', RealmPropertyType.bool, optional: true),
      SchemaProperty('address', RealmPropertyType.string, optional: true),
      SchemaProperty('bankname', RealmPropertyType.string, optional: true),
      SchemaProperty('branchname', RealmPropertyType.string, optional: true),
      SchemaProperty('country', RealmPropertyType.string, optional: true),
      SchemaProperty('createat', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('createby', RealmPropertyType.string, optional: true),
      SchemaProperty('postcode', RealmPropertyType.string, optional: true),
      SchemaProperty('swfitcode', RealmPropertyType.string, optional: true),
    ]);
  }();
  factory Banks.fromJson(Map<String, dynamic> json) {
    return Banks(
      ObjectId.fromHexString(json['_id']),
      createby: json['createby'],
      accounttype: json['accounttype'],
      accountname: json['accountname'],
      accountnumber: json['accountnumber'],
      active: json['active'],
      bankname: json['bankname'],
      branchname: json['branchname'],
      address: json['address'],
      postcode: json['postcode'],
      country: json['country'],
      swfitcode: json['swfitcode'],
      createat: DateTime.parse(json['createat']),
      v: json['__v'],
    );
  }
  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
