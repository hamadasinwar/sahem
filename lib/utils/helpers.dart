import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

OutlineInputBorder textFieldBorder(Color _color){
  return OutlineInputBorder(
    borderSide: BorderSide(color: _color, width: 2.2),
    borderRadius: BorderRadius.circular(15),
  );
}

OutlineInputBorder searchTextFieldBorder(){
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(14),
  );
}

List<String> states = [
  'شرق غزة',
  'شمال غزة',
  'غرب غزة',
  'خانيونس',
  'رفح',
  'الوسطى',
];

List<String> images = [
  'https://img.taste.com.au/m3W-xKYX/taste/2017/07/quick-and-easy-meal-planner-128684-2.jpg',
  'https://i.pinimg.com/originals/11/e0/40/11e0400ae1d6c0cbc4756ef16d20db66.jpg',
  'https://assets.adidas.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy,c_fill,g_auto/e725107a3d7041389f94ab220123fbcb_9366/Bravada_Shoes_Black_FV8085_01_standard.jpg',
  'https://m.media-amazon.com/images/I/61b02UQ7aKL._AC_UL1500_.jpg',
  'https://fdn.gsmarena.com/imgroot/news/21/04/oneplus-watch-update/-1200/gsmarena_002.jpg',
];


BoxDecoration decoration(BuildContext context, Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
    ),
  );
}