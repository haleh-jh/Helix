class User {
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  String lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;
  String type;
  String surname;
  String lastName;
  String institution;

  User(
      {required this.id,
      required this.userName,
      required this.normalizedUserName,
      required this.email,
      required this.normalizedEmail,
      required this.emailConfirmed,
      required this.passwordHash,
      required this.securityStamp,
      required this.concurrencyStamp,
      required this.phoneNumber,
      required this.phoneNumberConfirmed,
      required this.twoFactorEnabled,
      required this.lockoutEnd,
      required this.lockoutEnabled,
      required this.accessFailedCount,
      required this.type,
      required this.surname,
      required this.lastName,
      required this.institution, required dec,
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id']??"", userName: json['userName']?? "", accessFailedCount: json['accessFailedCount']?? "", concurrencyStamp: json['concurrencyStamp']?? "",
     dec: json['dec']??"", email: json['email']?? "", emailConfirmed: json['emailConfirmed'] ?? false, institution: json['institution']?? "", lastName: json['lastName']??"",
      lockoutEnabled: json['lockoutEnabled']?? false, lockoutEnd: json['lockoutEnd']?? "", normalizedEmail: json['normalizedEmail']?? "", normalizedUserName: json['normalizedUserName']?? "",
       passwordHash: json['passwordHash']?? "", phoneNumber: json['phoneNumber']?? "", phoneNumberConfirmed: json['phoneNumberConfirmed']?? false, securityStamp: json['securityStamp']?? "", surname: json['surname']??"",
        twoFactorEnabled: json['twoFactorEnabled']?? false, type: json['type']?? "", );
  }
}
