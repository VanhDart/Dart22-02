import 'package:flutter/material.dart';

import 'user_info.dart';



 class NextPage extends StatelessWidget {
  final UserInfo userInfo;
    const NextPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết Quả'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userInfo.name}'),
            Text('Email: ${userInfo.email}'),
            Text('Phone Number: ${userInfo.phoneNumber}'),
            Text('Birth Date: ${userInfo.birthDate?.day}/${userInfo.birthDate?.month}/${userInfo.birthDate?.year}'),
            Text('Street: ${userInfo.address?.street}'),
          ],
        ),
      ),
    );
  }
}
