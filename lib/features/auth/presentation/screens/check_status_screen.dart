







import 'package:flutter/material.dart';

class CheckStatusScreen extends StatelessWidget {
  const CheckStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}