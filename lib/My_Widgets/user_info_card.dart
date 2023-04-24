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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blueAccent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              SizedBox(width: size.width * 0.08),
              Container(
                width: size.width * 0.2,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'images/Mundo.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: size.width * 0.1),
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Text(
                    '${context.watch<AuthProvider>().userCachData!['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    '${context.watch<AuthProvider>().userCachData!['balance']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
