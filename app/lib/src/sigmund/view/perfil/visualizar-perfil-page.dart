import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-state.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class VisualizarPerfilPage extends StatefulWidget{
  Perfil perfil;

  VisualizarPerfilPage({this.perfil}){
  }

  State<StatefulWidget> createState()=>VisualizarPerfilState(perfil:perfil);
}



