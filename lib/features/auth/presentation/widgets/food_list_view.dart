import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reco_genie_task/core/utils/cart.dart';
import 'package:reco_genie_task/features/auth/presentation/widgets/food_list_view_item.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${item['name']} added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("food").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No food items found.'));
        }

        final foodDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: foodDocs.length,
          itemBuilder: (context, index) {
            final data = foodDocs[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FoodListViewItem(
                name: data['name'] ?? 'No name',
                price: data['price'] ?? 0,
                image: data['image'] ?? '',
                onAddToCart: () => addToCart(data),
              ),
            );
          },
        );
      },
    );
  }
}
