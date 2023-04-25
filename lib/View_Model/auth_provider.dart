import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voucher_giga/Data/Auth/auth.dart';
import 'package:voucher_giga/Data/Get_Vouchers/get_voucher_db.dart';
import 'package:voucher_giga/Model/user_model.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isloading = false;
  Map<String, dynamic>? userCachData;
  late String _email;
  late String _password = '';
  bool _isValid = false;

  late String _token;
  late User _user;
  late List<dynamic> _vouchers;
  final VoucherProvider _voucherProvider = VoucherProvider();

  String get email => _email;
  set email(String value) {
    _email = value;
    _validate();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    _validate();
  }

  bool get isValid => _isValid;

  void _validate() {
    _isValid = _email.isNotEmpty && _password.isNotEmpty;
    notifyListeners();
  }

  Future<void> loginFuction(String email, String password) async {
    isloading = true;
    notifyListeners();
    userCachData = await loginAPI(email, password);
    _token = userCachData!['token'];

    if (userCachData != null) {
      _user = User(
        name: userCachData!['name'],
        email: userCachData!['email'],
        id: userCachData!['id'],
        balance: userCachData!['balance'],
        token: userCachData!['token'],
      );
      final box = await Hive.openBox('UserData');
      await box.put('UserData', _user);
      print('this is the user Cach Data ====> ${_user.token}');

      await _voucherProvider.fetchVouchers(user.token);
      _vouchers = _voucherProvider.vouchers;
      print(_vouchers);
      // final vouchersResponse = await fetchVouchers(user.token);

      isloading = false;
      notifyListeners();
    }
  }

  String get token => _token;
  User get user => _user;
  List<dynamic> get vouchers => _vouchers;
}
