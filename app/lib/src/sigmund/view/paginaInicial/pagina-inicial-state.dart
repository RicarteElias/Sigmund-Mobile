import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/logo-image.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

class PaginaInicialState extends State<PaginaInicialPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context)=> buildScaffold();

  Scaffold buildScaffold()=>
      Scaffold(
        key:_scaffoldKey,
          body: Center(
            child: Container(
                 decoration: Constantes.BACKGROUND_GRADIENTE,
                child: Center(
                  child: colunaInicial()
    ),
  )
          )
      );


Column colunaInicial () =>Column(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[LogoImage(height: 0.4,),Padding(padding: EdgeInsets.only(top: 100),child: startButton(),)
  ],
);

Container startButton()=>Container(
  margin: EdgeInsets.all(20),
  child: NiceButton(width: 270,
    elevation: 8.0,
    radius: 52.0,
    text: "Iniciar Questionário",
    background: Constantes.ICON_COLOR,
    onPressed: () {
    _redirecionarPagina();
    },
  ),
);

_redirecionarPagina(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>QuizPage()), (page)=>false);
  }
}