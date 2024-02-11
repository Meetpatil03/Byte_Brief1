import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final String imagePath;
  final String title;
  final double widht;
  final double hieght;
  const LogoText({super.key, required this.imagePath, required this.title,required this.widht,required this.hieght});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: widht,
            height: hieght,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
