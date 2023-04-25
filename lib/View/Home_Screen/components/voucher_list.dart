import 'package:flutter/material.dart';

class VoucherList extends StatelessWidget {
  VoucherList({super.key});
  List colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.black,
    Colors.accents,
    Colors.amber,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Container(
            width: size.width * 0.02,
            height: size.height,
            color: colors[1],
          ),
          SizedBox(width: size.width * 0.1),
        ],
      ),
    );
  }
}
