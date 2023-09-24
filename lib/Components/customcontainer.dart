import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  //final Color? color;
  final double width;
  //final double height;
  final double vpad;
  final double hpad;

  const CustomContainer({Key? key,
    required this.child,
    //required this.color,
    required this.width,
    //required this.height,
    required this.vpad,
    required this.hpad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkTheme = brightness == Brightness.dark;
    Color lightShadow, darkShadow;
    if (isDarkTheme) {
      lightShadow = Colors.white.withOpacity(.12);// Set dark theme shadow color
      darkShadow = Colors.black.withOpacity(.90);
    } else {
      lightShadow = Colors.grey.shade100; // Set light theme shadow color
      darkShadow = Colors.black.withOpacity(0.15);
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: lightShadow,
            offset: Offset(-5,-5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: darkShadow,
            offset: Offset(5,5),
            blurRadius: 10,
          ),
        ]
      ),
      width: width,
      //height: height,
      padding: EdgeInsets.symmetric(vertical: vpad,horizontal: hpad),
      child: child,
    );
  }
}
