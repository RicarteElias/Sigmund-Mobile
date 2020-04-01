import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constantes {

  //Cores
  static final Color BACKGROUND = Color.fromRGBO(126, 57, 154, 1.0);
  static final Color ICON_COLOR = Color.fromRGBO(102, 16, 137, 1.0);

  //Variaveis normais
  static final String ICONE_LOGO = "assets/icons/icone-sigmund.png";


  //Widgets
  static final BACKGROUND_GRADIENTE = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(161, 26, 214, 1.0),
            Color.fromRGBO(56, 9, 74, 1.0)
          ]));
}