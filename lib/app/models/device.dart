// ignore_for_file: non_constant_identifier_names

class DeviceModel {
  final String? id, name, ip, vendor, model, location, ports, run_ports;

  DeviceModel(
      {required this.id,
      required this.name,
      required this.ip,
      required this.vendor,
      required this.model,
      required this.location,
      required this.ports,
      required this.run_ports});

  factory DeviceModel.fromMap(Map data) {
    return DeviceModel(
      id: data['id'],
      name: data['name'] ?? '',
      ip: data['ip'] ?? '',
      vendor: data['vendor'] ?? '',
      model: data['model'] ?? '',
      location: data['location'] ?? '',
      ports: data['ports'] ?? '',
      run_ports: data['run_ports'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ip": ip,
        "vendor": vendor,
        "model": model,
        "location": location,
        "ports": ports,
        "run_ports": run_ports
      };

  static DeviceModel fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json['id'],
        name: json['name'],
        ip: json['ip'],
        vendor: json['vendor'],
        model: json['model'],
        location: json['location'],
        ports: json['ports'],
        run_ports: json['run_ports'],
      );

  DeviceModel copy(
          {final String? id,
          name,
          ip,
          vendor,
          model,
          location,
          ports,
          run_ports}) =>
      DeviceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        ip: ip ?? this.ip,
        vendor: vendor ?? this.vendor,
        model: model ?? this.model,
        location: location ?? this.location,
        ports: ports ?? this.ports,
        run_ports: run_ports ?? this.run_ports,
      );
}
