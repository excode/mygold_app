// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Lang extends _Lang with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Lang(
    ObjectId id,
    String langCode,
    String key,
    String content,
    String ownerId, {
    bool isDone = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Lang>({
        'isDone': false,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'isDone', isDone);
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'langCode', langCode);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  Lang._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  bool get isDone => RealmObjectBase.get<bool>(this, 'isDone') as bool;
  @override
  set isDone(bool value) => RealmObjectBase.set(this, 'isDone', value);

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  String get langCode =>
      RealmObjectBase.get<String>(this, 'langCode') as String;
  @override
  set langCode(String value) => RealmObjectBase.set(this, 'langCode', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<Lang>> get changes =>
      RealmObjectBase.getChanges<Lang>(this);

  @override
  Lang freeze() => RealmObjectBase.freezeObject<Lang>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'isDone': isDone.toEJson(),
      'key': key.toEJson(),
      'langCode': langCode.toEJson(),
      'content': content.toEJson(),
      'owner_id': ownerId.toEJson(),
    };
  }

  Map<String, dynamic> toJson() {
    return {key.toString(): content};
  }

  static EJsonValue _toEJson(Lang value) => value.toEJson();
  static Lang _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'isDone': EJsonValue isDone,
        'key': EJsonValue key,
        'langCode': EJsonValue langCode,
        'content': EJsonValue content,
        'owner_id': EJsonValue ownerId,
      } =>
        Lang(
          fromEJson(id),
          fromEJson(langCode),
          fromEJson(key),
          fromEJson(content),
          fromEJson(ownerId),
          isDone: fromEJson(isDone),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Lang._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Lang, 'Lang', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('isDone', RealmPropertyType.bool),
      SchemaProperty('key', RealmPropertyType.string),
      SchemaProperty('langCode', RealmPropertyType.string),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
