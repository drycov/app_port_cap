// ignore_for_file: non_constant_identifier_names

class CNModel {
  final String? alt_name, name, cn_index;
  CNModel({this.alt_name, this.name, this.cn_index});

  factory CNModel.fromMap(Map data) {
    return CNModel(
      alt_name: data['alt_name'] ?? '',
      name: data['name'] ?? '',
      cn_index: data['cn_index'] ?? '',
    );
  }
  Map<String, dynamic> toJson() =>
      {"alt_name": alt_name, "name": name, "cn_index": cn_index};

  static CNModel fromJson(Map<String, dynamic> json) => CNModel(
      alt_name: json['alt_name'],
      name: json['name'],
      cn_index: json['cn_index']);

  CNModel copy({final String? alt_name, name, cn_index}) => CNModel(
      alt_name: alt_name ?? this.alt_name,
      name: name ?? this.name,
      cn_index: cn_index ?? this.cn_index);
}

class RegionModel {
  final String? alt_name, cn_alt_name, name, city_alt_name;
  RegionModel(
      {required this.alt_name,
      required this.city_alt_name,
      required this.cn_alt_name,
      required this.name});

  factory RegionModel.fromMap(Map data) {
    return RegionModel(
      cn_alt_name: data['cn_alt_name'],
      city_alt_name: data['city_alt_name'],
      alt_name: data['alt_name'],
      name: data['name'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "alt_name": alt_name,
        "name": name,
        'city_alt_name': city_alt_name,
        'cn_alt_name': cn_alt_name
      };

  static RegionModel fromJson(Map<String, dynamic> json) => RegionModel(
      alt_name: json['alt_name'],
      name: json['name'],
      city_alt_name: json['city_alt_name'],
      cn_alt_name: json['cn_alt_name']);

  RegionModel copy(
          {final String? alt_name, name, city_alt_name, cn_alt_name}) =>
      RegionModel(
        alt_name: alt_name ?? this.alt_name,
        name: name ?? this.name,
        city_alt_name: city_alt_name ?? this.city_alt_name,
        cn_alt_name: cn_alt_name ?? this.cn_alt_name,
      );
}

class LocationsModel {
  final String? alt_name, name, point;
  LocationsModel(
      {required this.alt_name, required this.point, required this.name});

  factory LocationsModel.fromMap(Map data) {
    return LocationsModel(
      point: data['point'],
      alt_name: data['alt_name'],
      name: data['name'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "alt_name": alt_name,
        "name": name,
        'point': point,
      };

  static LocationsModel fromJson(Map<String, dynamic> json) => LocationsModel(
      alt_name: json['alt_name'], name: json['name'], point: json['point']);

  LocationsModel copy({final String? alt_name, name, point}) => LocationsModel(
        alt_name: alt_name ?? this.alt_name,
        name: name ?? this.name,
        point: point ?? this.point,
      );
}

class CompanyPostsModel {
  final String? alt_name, name;
  final String? cn_index;
  CompanyPostsModel({this.alt_name, this.name, this.cn_index});

  factory CompanyPostsModel.fromMap(Map data) {
    return CompanyPostsModel(
      alt_name: data['alt_name'] ?? '',
      name: data['name'] ?? '',
      cn_index: data['alt_name'].toString().replaceAll(RegExp('([_]\\d+)'), ""),
    );
  }
  Map<String, dynamic> toJson() => {
        "alt_name": alt_name,
        "name": name,
        "cn_index": alt_name.toString().replaceAll(RegExp('([_]\\d+)'), "")
      };

  static CompanyPostsModel fromJson(
          Map<String, dynamic> json) =>
      CompanyPostsModel(
          alt_name: json['alt_name'],
          name: json['name'],
          cn_index:
              json['alt_name'].toString().replaceAll(RegExp('([_]\\d+)'), ""));

  CompanyPostsModel copy({final String? alt_name, name, cn_index}) =>
      CompanyPostsModel(
          alt_name: alt_name ?? this.alt_name,
          name: name ?? this.name,
          cn_index: alt_name.toString().replaceAll(RegExp('([_]\\d+)'), ""));
}

class CompanyDeportamentsModel {
  final String? alt_name, name;
  CompanyDeportamentsModel({this.alt_name, this.name});

  factory CompanyDeportamentsModel.fromMap(Map data) {
    return CompanyDeportamentsModel(
        alt_name: data['alt_name'] ?? '', name: data['name'] ?? '');
  }
  Map<String, dynamic> toJson() => {"alt_name": alt_name, "name": name};

  static CompanyDeportamentsModel fromJson(Map<String, dynamic> json) =>
      CompanyDeportamentsModel(alt_name: json['alt_name'], name: json['name']);

  CompanyDeportamentsModel copy({final String? alt_name, name}) =>
      CompanyDeportamentsModel(
          alt_name: alt_name ?? this.alt_name, name: name ?? this.name);
}

// cn_deportaments