import 'package:flutter/material.dart';
import 'package:fluttersqlite_02/pages/contactList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SQLite Demo',
      home: ContactListPage(),
    );
  }
}
