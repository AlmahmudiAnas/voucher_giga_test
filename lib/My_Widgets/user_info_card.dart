import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(150, 49, 111, 247),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), //to change position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            SizedBox(width: size.width * 0.1),
            Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Text(
                  'Hi, ${context.watch<AuthProvider>().userCachData!['name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 122, 122, 122),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text('Your balance:'),
                Text(
                  'LYD ${context.watch<AuthProvider>().userCachData!['balance']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 122, 122, 122),
                  ),
                ),
              ],
            ),
            SizedBox(width: size.width * 0.22),
            Container(
                width: size.width * 0.2,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: Icon(Icons.wallet),
                  onPressed: () {},
                  iconSize: size.width * 0.15,
                )),
          ],
        ),
      ),
    );
  }
}
