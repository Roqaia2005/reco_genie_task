import 'package:flutter/material.dart';
import 'package:reco_genie_task/core/colors.dart';
import 'package:reco_genie_task/core/utils/cart.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:reco_genie_task/features/auth/presentation/views/cart_view.dart';
import 'package:reco_genie_task/features/auth/presentation/widgets/food_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartView(cart: cart)),
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),

        child: Column(
          children: [
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  colors: [Colors.white, Color(0xff527DBC), Color(0xff2B3C60)],
                  "Welcome to DineFind!",
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "MarckScript-Regular",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              repeatForever: true,
            ),

            Text(
              "Explore our dishes",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "MarckScript-Regular",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(child: FoodListView()),
          ],
        ),
      ),
    );
  }
}
