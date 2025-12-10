import 'package:flutter/material.dart';

class ShoppingCarScreen extends StatelessWidget {
  static const name = 'shopping-car-screen';
  const ShoppingCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: const _FullScreenShoppinCar(),
    );
  }
}

class _FullScreenShoppinCar extends StatelessWidget {
  const _FullScreenShoppinCar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Icon(Icons.shopping_cart, size: 150), SizedBox(height: 20), Text('Your shopping car is empty'), SizedBox(height: 100)],
      ),
    );
  }
}
