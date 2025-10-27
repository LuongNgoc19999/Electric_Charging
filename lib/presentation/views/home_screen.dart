import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome ${user.name}")),
      body: Center(
        child: Text(
          "Email: ${user.email}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}