import 'package:flutter/material.dart';
import '../../../core/widgets/price_tag.dart';

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Warung Digital')),
        body: const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text('Selamat datang di Warung Digital'),
            SizedBox(height: 16),
            PriceTag(price: 'Rp 11.000'),
            SizedBox(height: 8),
            PriceTag(price: 'Rp 23.500'),
            SizedBox(height: 8),
            PriceTag(price: 'Rp 8.000'),
        ],
        ),
    ),
    );
}
}