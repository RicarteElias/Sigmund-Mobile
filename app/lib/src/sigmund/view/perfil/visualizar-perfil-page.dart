import 'package:app/src/sigmund/view/perfil/visualizar-perfil-state.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class VisualizarPerfilPage extends StatefulWidget{
  List<int> respostas;

  VisualizarPerfilPage({List <int> respostas}){
    this.respostas=respostas;
  }

  State<StatefulWidget> createState()=>VisualizarPerfilState(respostas: respostas);
}



