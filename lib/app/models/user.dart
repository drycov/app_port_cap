// cn"ttc-5"
// cn_deportament"sit"
// company_posts"sit_3"
// e_mail"d.rykov@ttc.kz"
// first_name"Денис"
// last_name"Рыков"
// region"region-5-3"
// uname"d.rykov"

class UserModel {
  final String? uid,
      email,
      name,
      cn,
      post,
      firstName,
      middleName,
      lastName,
      region,
      devID;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.cn,
      this.post,
      this.firstName,
      this.middleName,
      this.lastName,
      this.region,
      this.devID});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      cn: data['cn'] ?? '',
      region: data['region'] ?? '',
      post: data['post'] ?? '',
      firstName: data['firstName'] ?? '',
      middleName: data['middleName'] ?? '',
      lastName: data['lastName'] ?? '',
      devID: data['devID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "cn": cn,
        "region": region,
        "post": post,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "devID": devID
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        cn: json['cn'],
        region: json['region'],
        post: json['post'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        devID: json['devID'],
      );

  UserModel copy({
    String? uid,
    String? email,
    String? name,
    String? cn,
    String? region,
    String? post,
    String? firstName,
    String? middleName,
    String? lastName,
    String? devID,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        cn: cn ?? this.cn,
        region: region ?? this.region,
        post: post ?? this.post,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        devID: devID ?? this.devID,
      );
}
