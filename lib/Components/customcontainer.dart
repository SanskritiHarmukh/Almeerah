import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double width;
  final double height;
  final double vpad;
  final double hpad;

  const CustomContainer({Key? key,
    required this.child,
    required this.color,
    required this.width,
    required this.height,
    required this.vpad,
    required this.hpad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: Offset(-5,-5),
            blurRadius: 15,
          ),
          BoxShadow(
            color: Colors.grey.shade900,
            offset: Offset(5,5),
            blurRadius: 15,
          ),
        ]
      ),
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: vpad,horizontal: hpad),
      child: child,
    );
  }
}
