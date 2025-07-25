import 'package:flutter/material.dart';

class FoodListViewItem extends StatelessWidget {
  const FoodListViewItem({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.onAddToCart,
  });

  final String name;
  final String price;
  final String image;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '$price EGP',
          style: const TextStyle(color: Colors.green, fontSize: 14),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: onAddToCart,
        ),
      ),
    );
  }
}
