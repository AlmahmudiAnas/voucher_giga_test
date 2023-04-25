import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/user_info_card.dart';
import 'package:voucher_giga/View/Home_Screen/voucher_cart.dart';
import 'package:voucher_giga/View/Voucher_Qyantity/voucher_details.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    final voucherProvider = context.read<VoucherProvider>();
    voucherProvider.fetchVouchers(authProvider.user.token);
  }

  @override
  Widget build(BuildContext context) {
    final voucherProvider = context.watch<VoucherProvider>();
    final vouchers = voucherProvider.vouchers;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.grey.shade200.withOpacity(0.20),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //SizedBox(height: size.height * 0.1),
                UserInfoCard(),
                SizedBox(height: size.height * 0.05),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.5,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: vouchers.length,
                      itemBuilder: (BuildContext context, int index) {
                        //print(vouchers[index].validity);
                        return GestureDetector(
                          child: VoucherItem(voucher: vouchers[index]),
                          onTap: () {
                            Provider.of<VoucherProvider>(context, listen: false)
                                .voucherRequest
                                .addEntries({
                              MapEntry("voucher", vouchers[index].id),
                            });
                            Navigator.pushNamed(
                                context, VoucherDetails.routeName);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
