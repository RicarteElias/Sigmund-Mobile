import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarPerfilState extends State<VisualizarPerfilPage> {

  List<int> respostas;
  Perfil perfilDefinido;

  VisualizarPerfilState({this.respostas}){

  }

  @override
  Widget build(BuildContext context) {
    Scaffold(
      body: Container(
        decoration: Constantes.BACKGROUND_GRADIENTE,
        child: Center(

        ),
      ),
    );
  }

  String _perfilDefinido() {
    switch(perfilDefinido){
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

  String imagemPerfil(){
    switch(perfilDefinido){

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