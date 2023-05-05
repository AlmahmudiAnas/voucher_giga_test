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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              'images/giga2.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: size.height * 0.25),
                  Text(
                    'ادخل الكمية المراد سحبها',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: size.width * 0.3,
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Digistyle',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          controller: _voucherQuantity,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 196, 196, 196),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            filled: true,
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
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'تنفيد',
                          onPressed: () async {
                            Provider.of<VoucherProvider>(context, listen: false)
                                .voucherRequest
                                .addEntries({
                              MapEntry(
                                  "quantity", int.parse(_voucherQuantity.text))
                            });
                            final box = await Hive.openBox('UserData');
                            final currentUser = box.get('current_user');
                            await context.read<VoucherProvider>().buyVouchers(
                                voucherProvider.voucherRequest,
                                currentUser.token);
                            context.read<VoucherProvider>().connectPrinter();
                            Navigator.pop(context);
                          },
                        ),
                        CustomButton(
                          text: 'رجوع',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
