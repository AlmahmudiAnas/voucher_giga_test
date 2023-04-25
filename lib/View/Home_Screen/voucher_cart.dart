import 'package:flutter/material.dart';
import 'package:voucher_giga/Model/voucher_model.dart';

class VoucherItem extends StatelessWidget {
  final Voucher voucher;

  VoucherItem({required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            voucher.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Text(
            "${voucher.cost}\$",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text("Time: ${voucher.validity}"),

          // Text("Speed: ${voucher.downloadSpeed}"),
          // Text("Upload: ${voucher.uploadSpeed}"),
          // Text('Limit: ${voucher.quotaLimit}'),
        ],
      ),
    );
  }
}
