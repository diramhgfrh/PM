import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call API Test"),
        backgroundColor: Colors.green,
      ),
      body: const Text("Project Rest"),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUser,
        backgroundColor: Colors.green,
        child: const Icon(Icons.supervised_user_circle),
      ),
    );
  }

  void fetchUser() {
    print("fetching user data");
  }
}
