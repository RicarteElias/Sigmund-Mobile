import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaInicialPage extends StatefulWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  State<StatefulWidget> createState()=>PaginaInicialState();
}