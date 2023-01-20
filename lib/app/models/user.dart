// cn"ttc-5"
// cn_deportament"sit"
// company_posts"sit_3"
// e_mail"d.rykov@ttc.kz"
// first_name"Денис"
// last_name"Рыков"
// region"region-5-3"
// uname"d.rykov"

// ignore_for_file: non_constant_identifier_names

class UserModel {
  final String? uid,
      email,
      name,
      cn,
      cndp,
      company_posts,
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
      this.cndp,
      this.company_posts,
      this.firstName,
      this.middleName,
      this.lastName,
      this.region,
      this.devID});

  factory UserModel.fromMap(Map data) {
    // Globals.printMet('data', data.toString());
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      cn: data['cn'] ?? '',
      cndp: data['cndp'] ?? '',
      region: data['region'] ?? '',
      company_posts: data['company_posts'] ?? '',
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
        "cndp": cndp,
        "region": region,
        "company_posts": company_posts,
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
        cndp: json['cndp'],
        region: json['region'],
        company_posts: json['post'],
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
    String? cndp,
    String? region,
    String? company_posts,
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
        cndp: cndp ?? this.cndp,
        region: region ?? this.region,
        company_posts: company_posts ?? this.company_posts,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        devID: devID ?? this.devID,
      );
}
