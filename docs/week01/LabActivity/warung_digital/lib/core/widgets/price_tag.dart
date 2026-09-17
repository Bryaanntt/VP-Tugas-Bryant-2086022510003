import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
    final String price;

    const PriceTag({super.key, required this.price});

    @override
    Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
    ),
        child: Text(
        price,
        style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.orange,
        ),
    ),
    );
}
}