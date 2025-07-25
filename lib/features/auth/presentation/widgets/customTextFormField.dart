import 'package:flutter/material.dart';
import 'package:reco_genie_task/core/colors.dart';


class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.icon,

    required this.isRequired,
    required this.controller,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String? hintText;

  final bool isRequired;
  final IconData? icon;
  bool isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(
        children: [
          Container(
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFC3CBF0),
                  Color(0xFF9DAAE8),
                  Color(0xFFBCC5EE),
                  Color(0xFF93ABD9),
                ],
              ),
            ),
          ),
          TextFormField(
            cursorErrorColor: Colors.blue,
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              prefixIcon: Icon(widget.icon, color: AppColors.iconColor),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: AppColors.hintColor),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              errorStyle: TextStyle(
                color: const Color.fromARGB(255, 122, 21, 13),
                // fontWeight: FontWeight.bold,
              ),
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          color: AppColors.iconColor,

                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      )
                      : null,
            ),
            validator: (data) {
              if (widget.isRequired && (data == null || data.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
