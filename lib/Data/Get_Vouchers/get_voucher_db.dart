import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:voucher_giga/Model/voucher_model.dart';

String url = 'http://10.205.17.23:4000';

class VoucherService {
  Future<Map<String, dynamic>> getVouchers(String token) async {
    final response = await http.get(
      Uri.parse('$url/voucher-templates'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch vouchers');
    }
  }
}



// Future<List<dynamic>> fetchVouchers(String token) async {
//   final response =
//       await http.get(Uri.parse('$url/voucher-templates'), headers: {
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token',
//     'content-type': 'application/json',
//   });

//   if (response.statusCode == 200) {
//     //print(response.body);
//     final vouchersResponse = json.decode(response.body);
//     //print(vouchersResponse);
//     final vouchersList = vouchersResponse['data'] as List<dynamic>;
//     // print('$vouchersList');
//     //return vouchersResponse;

//     //final List<dynamic> jsonResponse = json.decode(response.body);
//     return vouchersList
//         .map((voucher) => Voucher.fromJson(voucher))
//         .cast()
//         .toList();
//   } else {
//     throw Exception('Failed to fetch vouchers');
//   }
// }





// Future<Map<String, dynamic>?> getVouchers(String token) async {
//   final response =
//       await http.get(Uri.parse('$url/voucher-templates'), headers: {
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token',
//     'content-type': 'application/json',
//   });
//   if (response.statusCode == 200) {
//     final jsonResponse = json.decode(response.body);
//     if (jsonResponse['msg'] == null) {
//       print('Reached Voucher list successfully');
//       print(response.body);
//       print("this is the jsonResponse ====> $jsonResponse");
//     }
//   } else {
//     print(response.statusCode);
//   }
// }

// Future<Map<String, dynamic>?> saveVoucherList(responseList) async {
//   final voucherList = Voucher(
//     name: responseList['data']['name'],
//     validity: responseList['data']['validity'],
//     cost: responseList['data']['cost'],
//     downloadSpeed: responseList['data']['download_speed'],
//     uploadSpeed: responseList['data']['upload_speed'],
//     quotaLimit: responseList['quota_limit'],
//     id: responseList['data']['id'],
//   );
//   try {
//     final box = await Hive.openBox<Voucher>('voucherData');
//     if (box != null) {
//       await box.put('voucherData', voucherList);
//       await box.close();
//       return {
//         'id': voucherList.id,
//         'name': voucherList.name,
//         'validity': voucherList.validity,
//         'cost': voucherList.cost,
//         'download_speed': voucherList.downloadSpeed,
//         'upload_speed': voucherList.uploadSpeed,
//         'quota_limit': voucherList.quotaLimit,
//       };
//     } else {
//       print('Box is null');
//       return null;
//     }
//   } catch (e) {
//     print('Error: $e');
//     return null;
//   }
// }
