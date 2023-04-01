// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      normalizedUserName: json['normalizedUserName'] as String,
      email: json['email'] as String,
      normalizedEmail: json['normalizedEmail'] as String,
      emailConfirmed: json['emailConfirmed'] as bool,
      passwordHash: json['passwordHash'] as String,
      securityStamp: json['securityStamp'] as String,
      concurrencyStamp: json['concurrencyStamp'] as String,
      phoneNumber: json['phoneNumber'] as String,
      phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool,
      twoFactorEnabled: json['twoFactorEnabled'] as bool,
      lockoutEnd: json['lockoutEnd'] as String,
      lockoutEnabled: json['lockoutEnabled'] as bool,
      accessFailedCount: json['accessFailedCount'] as String,
      type: json['type'] as String,
      surname: json['surname'] as String,
      lastName: json['lastName'] as String,
      institution: json['institution'] as String,
      des: json['des'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'normalizedUserName': instance.normalizedUserName,
      'email': instance.email,
      'normalizedEmail': instance.normalizedEmail,
      'emailConfirmed': instance.emailConfirmed,
      'passwordHash': instance.passwordHash,
      'securityStamp': instance.securityStamp,
      'concurrencyStamp': instance.concurrencyStamp,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberConfirmed': instance.phoneNumberConfirmed,
      'twoFactorEnabled': instance.twoFactorEnabled,
      'lockoutEnd': instance.lockoutEnd,
      'lockoutEnabled': instance.lockoutEnabled,
      'accessFailedCount': instance.accessFailedCount,
      'type': instance.type,
      'surname': instance.surname,
      'lastName': instance.lastName,
      'institution': instance.institution,
      'des': instance.des,
    };
