import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/user_info_card.dart';
import 'package:voucher_giga/My_Widgets/voucher_list.dart';
import 'package:voucher_giga/View/Home_Screen/voucher_card.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserInfoCard(),
                SizedBox(height: size.height * 0.05),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          context.watch<VoucherProvider>().vouchers.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Provider.of<VoucherProvider>(context, listen: false)
                                .voucherRequest
                                .addEntries({
                              MapEntry("voucher", vouchers[index].id),
                            });
                            Navigator.pushNamed(
                                context, VoucherDetails.routeName);
                          },
                          child: VoucherList(
                            voucher: vouchers[index],
                          ),
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
