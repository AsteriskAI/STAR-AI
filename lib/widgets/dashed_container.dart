import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class DashedContainer extends StatelessWidget {
  final Widget child; // Accept a child widget
  final double width;
  final Color borderColor;
  final double dashLength;
  final double borderWidth;
  final EdgeInsetsGeometry padding;

  const DashedContainer({
    Key? key,
    required this.child,
    this.width = 390,
    this.borderColor = const Color(0xff7CC4F1),
    this.dashLength = 2,
    this.borderWidth = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          border: DashedBorder(
            dashLength: dashLength,
            top: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: child, // Use the provided child widget here
        ),
      ),
    );
  }
}
