// ignore_for_file: avoid_print

// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:voucher_giga/Adapter/voucher_adapter.dart';
import 'package:voucher_giga/Data/Get_Vouchers/get_voucher_db.dart';
import 'package:voucher_giga/Data/New_Voucher/create_new_voucher_request.dart';
import 'package:voucher_giga/Model/user_model.dart';
import 'package:voucher_giga/Model/voucher_model.dart';
import 'package:path_provider/path_provider.dart';

class VoucherProvider extends ChangeNotifier {
  List<Voucher> _vouchers = [];
  VoucherService _voucherService = VoucherService();
  NewVoucherService _newVoucherService = NewVoucherService();
  Map<String, dynamic> _voucherRequest = {};
  var amount = 0;
  List<dynamic> _newVouchers = [];
  List<BluetoothDevice> devices = [];
  late BluetoothDevice printer;
  // List<BluetoothDevice> devices = [];
  // BluetoothDevice? selectedDevice;
  // BlueThermalPrinter printer = BlueThermalPrinter.instance;

  List<Voucher> get vouchers => _vouchers;
  Map<String, dynamic> get voucherRequest => _voucherRequest;
  List<dynamic> get newVouchers => _newVouchers;

  Future<void> fetchVouchers(String token) async {
    try {
      final vouchersResponse = await _voucherService.getVouchers(token);
      final vouchersData = vouchersResponse['data'] as List<dynamic>;

      final vouchers =
          vouchersData.map((voucher) => Voucher.fromJson(voucher)).toList();

      // Saving vouchers to local database
      final box = await Hive.openBox('vouchers');

      box.put('vouchers', vouchers);

      _vouchers = vouchers;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> init() async {
    try {
      // Initializing Hive
      final appDocDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocDir.path);

      // Registering VoucherAdapter for serialization/deserialization
      Hive.registerAdapter(VoucherAdapter());

      // Opening the vouchers box and reading the saved vouchers
      final box = await Hive.openBox('vouchers');
      final vouchers = box.get('vouchers', defaultValue: []) as List<Voucher>;

      _vouchers = vouchers;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<String> getToken() async {
    final userBox = await Hive.openBox('UserData');
    final currentUser = userBox.get('current_user');
    print(currentUser);
    return currentUser.token;
  }

  Future newVouchersMethod(
      Map<String, dynamic> newVoucherMap, String token) async {
    final response =
        await _newVoucherService.buyVouchers(voucherRequest, token);
    _newVouchers = response;
    // ignore: avoid_print
    print("This is the final response ==> $_newVouchers");
    notifyListeners();
  }

  void connectPrinter() async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    for (final device in devices) {
      if (device.name == 'ZCSPrint') {
        printer = device;
        break;
      }
    }
// Connect to the printer
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(printer.address);
    // Send voucher data to the printer
    // final Uint8List voucherData =
    //     Uint8List.fromList('Voucher data here'.codeUnits);
    // connection.output.add(voucherData);
    for (var entry in _newVouchers) {
      final name = entry['name'];
      final code = entry['code'];
      final validity = entry['validity'];
      final cost = entry['cost'];
      final upload = entry['upload_speed'];
      final download = entry['download_speed'];
      final qouta = entry['qouta_limit'];
      final line = '\x1B\x21\x00Name: $name\x1B\x21\x30\n\n';
      final codeLine = '\x1B\x21\x30\n\x1B\x21\x00Code: $code';
      final validityLine = '\x1B\x21\x30\n\x1B\x21\x00Time: $validity';
      final costLine = '\x1B\x21\x30\n\x1B\x21\x00Cost: $cost';
      final qoutaLine = '\x1B\x21\x30\n\x1B\x21\x00Qouta: $qouta';
      final dSpeed = '\x1B\x21\x30\n\x1B\x21\x00Download speed: $download';
      final uSpeed = '\x1B\x21\x30\n\x1B\x21\x00Upload: $upload';

      final bytes = utf8.encode(line);
      final Uint8List uint8list = Uint8List.fromList(bytes);
      connection.output.add(uint8list);
    }
    await connection.output.allSent;
    await connection.finish();

// Close the connection
    await connection.finish();
  }

  // void getDevices() async {
  //   devices = await printer.getBondedDevices();
  //   notifyListeners();
  // }

  // void deviceSelected(device) {
  //   selectedDevice = device;
  //   print(selectedDevice!.name);
  //   printer.connect(selectedDevice!);
  //   notifyListeners();
  // }

//   Future<void> printVoucher() async {
//     print(selectedDevice!.name);
//     try {
//       if ((await printer.isConnected)!) {
//         for (final voucher in _newVouchers) {
//           // Create the voucher string to print
//           // final voucherString =
//           //     '${voucher['name']}\n\nCode: ${voucher['code']}\nValidity: ${voucher['validity']}\nCost: ${voucher['cost']}';

//           // // Print the voucher
//           // await printer.printCustom(voucherString, 0, 0);
//           // await printer.printNewLine();
//           print(voucher['code']);
//           await printer.printNewLine();
//           await printer.printCustom('Giga voucher', 1, 1);
//           await printer.printNewLine();
//           await printer.printCustom('Voucher code', 1, 1);
//           await printer.printNewLine();
//           await printer.printCustom('${voucher['code']}', 3, 1);
//           await printer.printNewLine();
//           await printer.printCustom(
//               '${voucher['name']}, ${voucher['validity']}, ${voucher['cost']}, ${voucher['quota_limit']}',
//               1,
//               0);
//           await printer.printNewLine();
//           await printer.printCustom(
//               '${voucher['download_speed']}, ${voucher['upload_speed']}', 1, 0);
//           await printer.printQRcode('${voucher['code']}', 200, 200, 0);
//         }
//       } else {
//         print('printer not connected');
//       }
//     } catch (e) {
//       print('error printing vouchers: $e');
//     } finally {
//       printer.disconnect();
//     }
//   }
// }
  //Sizes
  // 0 - Normal
  // 1 - Normal Bold
  // 2 - Medium Bold
  // 3 - Large Bold
  //
  // Align
  // 0 - Left
  // 1 - center
  // 2 - right
}
