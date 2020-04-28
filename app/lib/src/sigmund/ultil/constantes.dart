import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Constantes para serem usadas no aplicativo

class Constantes {

  //Cores
  static const Color BACKGROUND = Color.fromRGBO(126, 57, 154, 1.0);
  static const Color ICON_COLOR = Color.fromRGBO(102, 16, 137, 1.0);

  //Variaveis imagens
  static const String ICONE_LOGO = "assets/icons/icone-sigmund.png";
  static const String IMAGE_ANALISTA = "assets/perfis/analista.png";
  static const String IMAGE_COMUNICADOR = "assets/perfis/comunicador.png";
  static const String IMAGE_EXECUTOR = "assets/perfis/executor.png";
  static const String IMAGE_PLANEJADOR= "assets/perfis/planejador.png";
  static const int TIME_MESSAGE = 3;


  //Widgets
  static const BACKGROUND_GRADIENTE = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(161, 26, 214, 1.0),
            Color.fromRGBO(56, 9, 74, 1.0)
          ]));
}