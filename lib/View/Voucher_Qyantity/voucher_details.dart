import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/my_button.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';

class VoucherDetails extends StatefulWidget {
  const VoucherDetails({super.key});
  static String routeName = 'voucher details';

  @override
  State<VoucherDetails> createState() => _VoucherDetailsState();
}

class _VoucherDetailsState extends State<VoucherDetails> {
  TextEditingController _voucherQuantity = TextEditingController();
  AuthProvider authProvider = AuthProvider();
  VoucherProvider voucherProvider = VoucherProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<VoucherProvider>().getDevices();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Text('ادخل الكمية المراد سحبها'),
              SizedBox(height: size.height * 0.02),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _voucherQuantity,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: false,
                    label: Text('عدد البطاقات'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 3,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              // DropdownButton(
              //   hint: Text('اختر الطابعة'),
              //   onChanged: (device) =>
              //       context.read<VoucherProvider>().deviceSelected(device),
              //   value: context.watch<VoucherProvider>().selectedDevice,
              //   items: context
              //       .watch<VoucherProvider>()
              //       .devices
              //       .map((e) => DropdownMenuItem(
              //             child: Text(e.name!),
              //             value: e,
              //           ))
              //       .toList(),
              // ),
              SizedBox(height: size.height * 0.1),
              CustomButton(
                text: 'سحب بطاقات',
                onPressed: () async {
                  // context.read<VoucherProvider>().newVouchers(
                  //     "quantity", int.parse(_voucherQuantity.text));
                  Provider.of<VoucherProvider>(context, listen: false)
                      .voucherRequest
                      .addEntries({
                    MapEntry("quantity", int.parse(_voucherQuantity.text))
                  });
                  print(voucherProvider.voucherRequest);
                  final box = await Hive.openBox('UserData');
                  final currentUser = box.get('current_user');
                  //print(currentUser.token);
                  await context.read<VoucherProvider>().newVouchersMethod(
                      voucherProvider.voucherRequest, currentUser.token);
                  // voucherProvider.printVoucher();
                  context.read<VoucherProvider>().connectPrinter();
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
