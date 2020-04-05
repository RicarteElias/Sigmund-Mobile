import 'dart:math';

import 'package:app/src/sigmund/resource/perfil.dart';

class DefinirPerfil{

  List<int> respostas;
  DefinirPerfil(this.respostas);

  // ignore: missing_return
  Perfil definirPerfil(){
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
     case 3: {
       return Perfil.planejador;
     }
   }
 }
}