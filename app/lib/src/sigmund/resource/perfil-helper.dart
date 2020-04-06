import 'dart:math';

import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';

class PerfilHelper{

  static Perfil getPerfil(List<int> respostas){
    respostas[0]= respostas[0] *4;
    respostas[1]= respostas[1] *4;
    respostas[2]= respostas[2] *4;
    respostas[3]= respostas[3] *4;

    int perfil = respostas.indexOf(respostas.reduce(max));
    switch(perfil) {
      case 0: {
        return Perfil.analista;
      }
      case 1: {
        return Perfil.comunicador;
      }
      case 2: {
        return Perfil.executor;
      }
      default: {
        return Perfil.planejador;
      }
    }


  }

  // ignore: missing_return
  static String getValue(Perfil perfil){
    switch( perfil ){
      case Perfil.analista:
        return "Analista";
      case Perfil.comunicador:
        return "Comunicador";
      case Perfil.executor:
        return "Executor";
      case Perfil.planejador:
        return "Planejador";
    }

  }

  // ignore: missing_return
  static String getImage(Perfil perfil){

    switch(perfil){
      case Perfil.analista:
        return Constantes.IMAGE_ANALISTA;
      case Perfil.comunicador:
        return Constantes.IMAGE_COMUNICADOR;
      case Perfil.executor:
        return Constantes.IMAGE_EXECUTOR;
      case Perfil.planejador:
        return Constantes.IMAGE_PLANEJADOR;
    }

  }


}