import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User(
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
      required String des}) = _User;
}
