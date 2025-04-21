import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/ui/_core/app_colors.dart';

class ItemCart extends StatelessWidget {
  final Dish dish;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ItemCart({
    super.key,
    required this.dish,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/dishes/default.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'R\$ ${dish.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle, color: AppColors.mainColor),
                onPressed: onDecrease,
              ),
              Text('$quantity', style: const TextStyle(color: Colors.white)),
              IconButton(
                icon: Icon(Icons.add_circle, color: AppColors.mainColor),
                onPressed: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
