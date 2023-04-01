import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/user.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel(
      {required String id,
      required String userName,
      required String normalizedUserName,
      required String email,
      required String normalizedEmail,
      required bool emailConfirmed,
      required String passwordHash,
      required String securityStamp,
      required String concurrencyStamp,
      required String phoneNumber,
      required bool phoneNumberConfirmed,
      required bool twoFactorEnabled,
      required String lockoutEnd,
      required bool lockoutEnabled,
      required String accessFailedCount,
      required String type,
      required String surname,
      required String lastName,
      required String institution,
      required String des}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User(id: id, userName: userName, normalizedUserName: normalizedUserName, email: email, normalizedEmail: normalizedEmail, emailConfirmed: emailConfirmed, passwordHash: passwordHash, securityStamp: securityStamp, concurrencyStamp: concurrencyStamp, phoneNumber: phoneNumber, phoneNumberConfirmed: phoneNumberConfirmed, twoFactorEnabled: twoFactorEnabled, lockoutEnd: lockoutEnd, lockoutEnabled: lockoutEnabled, accessFailedCount: accessFailedCount, type: type, surname: surname, lastName: lastName, institution: institution, des: des);
}
