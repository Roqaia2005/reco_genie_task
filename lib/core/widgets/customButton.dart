import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onPressed, required this.text});
  final void Function()? onPressed;
 final  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2B3C60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: "Amaranth-Regular",
            ),
          ),
        ),
      ),
    );
  }
}
