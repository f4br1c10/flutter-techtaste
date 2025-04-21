import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/ui/_core/app_colors.dart';
import 'package:myapp/ui/_core/bag_provider.dart';
import 'package:myapp/ui/_core/widgets/appBar.dart';
import 'package:provider/provider.dart';

class DishDetailPage extends StatefulWidget {
  final Dish dish;
  const DishDetailPage({super.key, required this.dish});

  @override
  State<DishDetailPage> createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dish = widget.dish;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: getAppBar(context: context, title: dish.name),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/dishes/default.png',
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              dish.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.priceColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'R\$${dish.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              dish.description,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: decrement,
                  icon: Icon(Icons.remove_circle_outline),
                  color: AppColors.mainColor,
                  iconSize: 30.0,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                IconButton(
                  onPressed: increment,
                  icon: Icon(Icons.add_circle_outline_rounded),
                  color: AppColors.mainColor,
                  iconSize: 30.0,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    () => context.read<BagProvider>().addAllDishes([dish]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text('Adicionar', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
