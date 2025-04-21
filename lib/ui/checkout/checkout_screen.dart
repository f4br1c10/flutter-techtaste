import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';
import 'package:myapp/ui/_core/app_colors.dart';
import 'package:myapp/ui/_core/bag_provider.dart';
import 'package:myapp/ui/checkout/widgets/item_cart_widget.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final Dish? dish;
  const CheckoutScreen({super.key, this.dish});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Map<Dish, int> cart = {
    Dish(
          id: '412414',
          name: 'Frango ao Curry',
          price: 29,
          description: 'werwere',
          imagePath: 'https://via.placeholder.com/150',
        ):
        1,
    Dish(
          id: 'dgdfgd',
          name: 'Espaguete à Bolonhesa',
          price: 24,
          description: 'dasdfsadf',
          imagePath: 'https://via.placeholder.com/150',
        ):
        1,
  };

  void increaseQuantity(Dish dish) {
    setState(() {
      cart[dish] = (cart[dish] ?? 0) + 1;
    });
  }

  void decreaseQuantity(Dish dish) {
    setState(() {
      if ((cart[dish] ?? 0) > 1) {
        cart[dish] = cart[dish]! - 1;
      } else {
        cart.remove(dish);
      }
    });
  }

  double get totalPrice => cart.entries.fold(
    0.0,
    (sum, entry) => sum + entry.key.price * entry.value,
  );

  @override
  Widget build(BuildContext context) {
    const deliveryFee = 6.00;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sacola'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.read<BagProvider>().clearBag(),
            child: const Text(
              'Limpar',
              style: TextStyle(color: AppColors.mainColor, fontSize: 16.0),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lista de itens
            const Text(
              'Pedido',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ...cart.entries.map(
              (entry) => ItemCart(
                dish: entry.key,
                quantity: entry.value,
                onIncrease: () => increaseQuantity(entry.key),
                onDecrease: () => decreaseQuantity(entry.key),
              ),
            ),

            const SizedBox(height: 24),

            // Pagamento
            const Text(
              'Pagamento',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.credit_card, color: Colors.white),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'VISA Classic\n**** **** **** 0976',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.orange[300]),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Endereço
            const Text(
              'Entregar no endereço:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Rua das Acácias, 28\nCasa 10',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Confirmação
            const Text(
              'Confirmar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pedido',
                        style: TextStyle(color: AppColors.mainColor),
                      ),
                      Text(
                        'R\$ ${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Entrega', style: TextStyle(color: Colors.grey)),
                      Text('R\$ 6.00', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'R\$ ${(totalPrice + deliveryFee).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text('Pedir', style: TextStyle(fontSize: 16.0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
