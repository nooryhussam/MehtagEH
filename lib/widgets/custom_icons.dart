import 'package:flutter/material.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({super.key, required this.imagepath});
  final String imagepath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(imagepath),
      ),
    );
  }
}
