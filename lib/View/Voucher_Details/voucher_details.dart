// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/my_button.dart';
import 'package:voucher_giga/View/Home_Screen/home_screen.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';

class NewVoucherDetails extends StatelessWidget {
  NewVoucherDetails({super.key});
  static String routeName = 'New Voucher Details';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var voucherProvider =
        Provider.of<VoucherProvider>(context); // get the provider instance

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              'images/GIGA.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: voucherProvider.newVouchers.length,
                itemBuilder: (context, index) {
                  print(voucherProvider.newVouchers[index]['code']);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'رقم الكرت ${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          height: size.height * 0.07,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          child: Center(
                              child: Text(
                            '${voucherProvider.newVouchers[index]['code']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
              bottom: size.height * 0.1,
              right: size.width * 0.4,
              child: CustomButton(
                onPressed: () {
                  context.read<VoucherProvider>().connectPrinter();
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                text: 'طباعة',
              ))
        ],
      ),
    );
  }
}

class VoucherCodeContainer extends StatelessWidget {
  const VoucherCodeContainer(
      {super.key, required this.size, required this.code});

  final Size size;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.3,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Text('voucher'),
          SizedBox(height: size.height * 0.02),
          Container(
            height: size.height * 0.08,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('code'),
          )
        ],
      ),
    );
  }
}
