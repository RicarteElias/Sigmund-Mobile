import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/logo-image.dart';
import 'package:app/src/sigmund/view/splash/pagina-inicial-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaInicialState extends State<PaginaInicialPage>{
  @override

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context)=> buildScaffold();

  Scaffold buildScaffold()=>
      Scaffold(
          body: Center(
      child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromRGBO(161, 26, 214, 1.0), Color.fromRGBO(56, 9, 74, 1.0)])),
  child: Center(
  child: colunaInicial()
  ),
  )));


Column colunaInicial () =>Column(
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.end,
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: <Widget>[LogoImage(height: 0.4,),Padding(padding: EdgeInsets.only(top: 50))
  ],
);



}