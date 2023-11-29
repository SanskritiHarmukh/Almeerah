import 'package:flutter/material.dart';

class TextFieldDecorations {

  static InputDecoration Customdecoration(String hintText,IconData icon) {
    return InputDecoration(
      hintText: hintText,
      label: Text(hintText),
      border: InputBorder.none,
      icon: Icon(icon,size: 24,),
    );
  }
  static BoxDecoration CustomBoxDeco(){
    return BoxDecoration(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(8),
    );
  }
}