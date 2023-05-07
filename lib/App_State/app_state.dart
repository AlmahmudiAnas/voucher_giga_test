import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voucher_giga/Adapter/user_adapter.dart';
import 'package:voucher_giga/Model/user_model.dart';

class AppState extends ChangeNotifier {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initialize() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter<User>(UserAdapter());
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    Hive.registerAdapter<User>(UserAdapter());
    final box = await Hive.openBox<User>('UserData');
    final userData = box.get('current_user');

    if (userData != null) {
      _isLoggedIn = true;
    }

    notifyListeners();
  }
}
