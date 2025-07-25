import 'package:flutter/material.dart';
import 'package:reco_genie_task/core/colors.dart';

class CartView extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartView({super.key, required this.cart});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  void removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
  }

  double getTotalPrice() {
    return widget.cart.fold(0.0, (total, item) {
      final price = item['price'];
      if (price is int) return total + price.toDouble();
      if (price is double) return total + price;
      return total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(title: const Text("Your Cart")),
      body:
          widget.cart.isEmpty
              ? const Center(child: Text("Cart is empty"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        final item = widget.cart[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.image_not_supported),
                              ),
                            ),
                            title: Text(item['name'] ?? 'Unnamed'),
                            subtitle: Text('${item['price']} EGP'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeItem(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total: ${getTotalPrice().toStringAsFixed(2)} EGP',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
