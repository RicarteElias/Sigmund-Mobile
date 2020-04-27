import 'package:app/src/sigmund/ultil/componentes/qr-code.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/componentes/logo-image.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginaInicialState extends State<PaginaInicialPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String test;

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
  children: <Widget>[LogoImage(height: 0.4,),Padding(padding: EdgeInsets.only(top: 100),child: _startButtons(),)
  ],
);

 Column _startButtons()=> Column(children: <Widget>[
   StartButton(onPressed: _iniciarProjeto,texto: "Participar Projeto",),
   _paddingBotoes(),
   StartButton(onPressed: _callQrCodeScan,texto: "Ler QR Code",),
   _paddingBotoes(),
   StartButton(onPressed: _redirecionarPagina,texto: "Iniciar Questionário",),
   _paddingBotoes(),
   StartButton(onPressed: _redirecionarPagina,texto: "Método Disc",)],);

_redirecionarPagina()=>
    Get.to(QuizPage());


Padding _paddingBotoes()=>Padding(padding:EdgeInsets.only(top: 20));

_callQrCodeScan() async {
  QrCodeScanner().scan().then((returnScan){
    print(returnScan);});
  }
  _iniciarProjeto()=>Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ParticiparProjetoPage()),
          (page) => false);
}