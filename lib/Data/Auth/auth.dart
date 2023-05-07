import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:voucher_giga/Model/user_model.dart';
import 'package:voucher_giga/Model/voucher_model.dart';

String url = 'http://10.205.17.23:4000';
Future<Map<String, dynamic>?> loginAPI(String email, String password) async {
  String token;
  final response = await http.post(
    Uri.parse('$url/login'),
    body: jsonEncode({'email': email, "password": password}),
    headers: {
      'Accept': 'application/json',
      //'Authorization' : 'Bearer $value',
      'content-type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    try {
      print("login success");
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['msg'] == null) {
        token = jsonResponse['data']['token'];
        final userProfile =
            await http.get(Uri.parse('$url/users/profile'), headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        });
        final userProfileDecoded = json.decode(userProfile.body);
        // print("this is the user profile =====> ${userProfile.body}");
        // print(response.body);
        // print("this is the jsonResponse ====> $jsonResponse");
        //getVouchers(token);
        return saveUserDataToCache(jsonResponse, token, userProfileDecoded);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: 'Email or password is incorrect',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
      );
    }
  }
}

Future<Map<String, dynamic>?> saveUserDataToCache(
    jsonResponse, token, userBalance) async {
  final userData = User(
    name: jsonResponse['data']['name'],
    email: jsonResponse['data']['email'],
    id: jsonResponse['data']['id'],
    balance: userBalance['data']['balance'].toString(),
    token: token,
  );
  try {
    // Open the UserData box
    final box = await Hive.openBox<User>('UserData');

    if (box != null) {
      // Put the user data in the box
      await box.put('current_user', userData);

      // Print all the users in the box
      // for (var i = 0; i < box.length; i++) {
      //   final user = box.getAt(i);
      //   print(
      //       'User info ==> ${user!.id}, ${user.name}, ${user.email}, ${user.balance}, ${user.token}');
      // }

      // Close the box
      await box.close();

      return {
        'name': userData.name,
        'email': userData.email,
        'id': userData.id,
        'balance': userData.balance,
        'token': userData.token,
      };
    } else {
      print('Box is null');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
