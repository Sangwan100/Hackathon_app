import 'package:flutter/material.dart';

import './screens/request_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PH Fill',
      color: Color.fromRGBO(13, 132, 155, 1),
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(13, 132, 155, 1),
      ),
      home: RequestPage(),
    );
  }
}
