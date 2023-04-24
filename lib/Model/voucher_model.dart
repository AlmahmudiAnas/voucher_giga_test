// class Voucher {
//   final String name, validity, cost, downloadSpeed, uploadSpeed, quotaLimit;
//   final int id;
//   Voucher({
//     required this.name,
//     required this.validity,
//     required this.cost,
//     required this.downloadSpeed,
//     required this.uploadSpeed,
//     required this.quotaLimit,
//     required this.id,
//   });

//   factory Voucher.fromJson(Map<String, dynamic> json) {
//     return Voucher(
//         name: json['name'],
//         validity: json['validity'],
//         cost: json['cost'],
//         downloadSpeed: json['download_speed'],
//         uploadSpeed: json['upload_speed'],
//         quotaLimit: json['quota_limit'],
//         id: json['id']);
//   }
// }

class Voucher {
  final int id;
  final String name;
  final String validity;
  final String cost;
  final String downloadSpeed;
  final String uploadSpeed;
  final String quotaLimit;

  Voucher({
    required this.id,
    required this.name,
    required this.validity,
    required this.cost,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.quotaLimit,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'] as int,
      name: json['name'] as String,
      validity: json['validity'] as String,
      cost: json['cost'] as String,
      downloadSpeed: json['download_speed'] as String,
      uploadSpeed: json['upload_speed'] as String,
      quotaLimit: json['quota_limit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'validity': validity,
      'cost': cost,
      'download_speed': downloadSpeed,
      'upload_speed': uploadSpeed,
      'quota_limit': quotaLimit,
    };
  }
}
