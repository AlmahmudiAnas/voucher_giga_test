import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/Adapter/voucher_adapter.dart';
import 'package:voucher_giga/App_State/app_state.dart';
import 'package:voucher_giga/Model/voucher_model.dart';
import 'package:voucher_giga/View/Login_Screen/login_screen.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';
import 'package:voucher_giga/routes.dart';
import 'Adapter/user_adapter.dart';
import 'Model/user_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  Hive.registerAdapter<Voucher>(VoucherAdapter());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<VoucherProvider>(
      create: (context) => VoucherProvider(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appState = AppState();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   appState.initialize().timeout(Duration(seconds: 10), onTimeout: () {
  //     print('Hive initialization timed out');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LoginScreen(),
      routes: routes,
      initialRoute: LoginScreen.routeName,
    );
  }
}
