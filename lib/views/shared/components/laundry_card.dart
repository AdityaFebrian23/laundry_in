import 'package:flutter/material.dart';
import '../../../models/laundry.dart';

class LaundryCard extends StatelessWidget {
  final LaundryModel laundry;
  final VoidCallback? onTap;
  const LaundryCard({super.key, required this.laundry, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      title: Text(laundry.name),
      subtitle: Text(laundry.description),
      onTap: onTap,
    ));
  }
}
