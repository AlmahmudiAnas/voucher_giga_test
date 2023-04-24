import 'dart:convert';
import 'package:http/http.dart' as http;

class NewVoucherService {
  String url = 'http://10.205.17.23:4000';

  Future<List<dynamic>> buyVouchers(
      Map<String, dynamic> voucherMap, String token) async {
    final response = await http.post(
      Uri.parse("$url/vouchers"),
      headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
        'Content-Type': "application/json",
      },
      body: json.encode(voucherMap),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final vouchers = responseData['data'];
      //print("this is the server response ===> $vouchers");
      return vouchers;
    } else {
      print(response.statusCode);
      throw Exception("Failed to buy vouchers");
    }
  }
}
