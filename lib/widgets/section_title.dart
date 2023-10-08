import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xff7CC4F1),
        fontSize: 40,
        shadows: [
          Shadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
