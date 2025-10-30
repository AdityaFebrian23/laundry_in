import 'package:flutter/material.dart';
import '../../models/laundry.dart';

class LaundryDetailPage extends StatelessWidget {
  final LaundryModel laundry;
  const LaundryDetailPage({super.key, required this.laundry});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(laundry.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              laundry.name,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              laundry.description,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 6),
                Text(laundry.rating?.toStringAsFixed(1) ?? '-'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
