import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-state.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-state.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class VisualizarPerfilPage extends StatefulWidget{
  List<int> respostas;

  VisualizarPerfilPage({List <int> respostas}){
    this.respostas=respostas;
  }

  @override
  State<StatefulWidget> createState()=>VisualizarPerfilState(respostas: this.respostas);
}



