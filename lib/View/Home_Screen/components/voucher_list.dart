import 'package:flutter/material.dart';
import 'package:voucher_giga/Model/voucher_model.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';

class VoucherList extends StatelessWidget {
  VoucherList({super.key, required this.voucher});
  VoucherProvider voucherProvider = VoucherProvider();
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(120, 16, 166, 249),
        // gradient: LinearGradient(
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        //   colors: [
        //     Colors.white,
        //     Color.fromARGB(255, 197, 195, 198),
        //   ],
        //   stops: [0.5, 1],
        // ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(190, 49, 111, 247),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), //to change position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   width: size.width * 0.04,
          //   height: size.height,
          //   decoration: BoxDecoration(
          //     color: voucherProvider.colors[1],
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         bottomLeft: Radius.circular(20)),
          //   ),
          // ),
          SizedBox(width: size.width * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  voucher.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  voucher.validity,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.42),
          Text(
            voucher.quotaLimit,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
