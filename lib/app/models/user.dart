class UserModel {
  final String? uid,
      email,
      name,
      cn,
      post,
      firstName,
      middleName,
      lastName,
      photoUrl,
      fileName,
      devID;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.cn,
      required this.post,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.fileName,
      required this.photoUrl,
      required this.devID});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      cn: data['cn'] ?? '',
      post: data['post'] ?? '',
      firstName: data['firstName'] ?? '',
      middleName: data['middleName'] ?? '',
      lastName: data['lastName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      fileName: data['fileName'] ?? '',
      devID: data['devID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "cn": cn,
        "post": post,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "photoUrl": photoUrl,
        "fileName": fileName,
        "devID": devID
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        cn: json['cn'],
        post: json['post'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        photoUrl: json['photoUrl'],
        fileName: json['fileName'],
        devID: json['devID'],
      );

  UserModel copy({
    String? uid,
    String? email,
    String? name,
    String? cn,
    String? post,
    String? firstName,
    String? middleName,
    String? lastName,
    String? photoUrl,
    String? fileName,
    String? devID,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        cn: cn ?? this.cn,
        post: post ?? this.post,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        photoUrl: photoUrl ?? this.photoUrl,
        fileName: fileName ?? this.fileName,
        devID: devID ?? this.devID,
      );
}
