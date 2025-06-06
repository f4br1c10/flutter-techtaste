import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/ui/_core/widgets/appBar.dart';
import 'package:myapp/ui/restaurant/widgets/card_dishes_widget.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: restaurant.name),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 12.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/${restaurant.imagePath}', width: 128),
                Text(
                  'Mais pedidos',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Column(
                  spacing: 8.0,
                  children: List.generate(restaurant.dishes.length, (index) {
                    Dish dish = restaurant.dishes[index];
                    return CardDishesWidget(dish: dish);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
