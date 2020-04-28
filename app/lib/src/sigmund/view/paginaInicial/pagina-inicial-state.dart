import 'package:app/src/sigmund/ultil/componentes/qr-code.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/componentes/logo-image.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  children: <Widget>[LogoImage(height: 0.4,), Spacer(),_startButtons(),
  ],
);

 Column _startButtons()=> Column(children: <Widget>[
   StartButton(onPressed: _iniciarProjeto,texto: "Participar Projeto",),
   _paddingBotoes(),
   StartButton(onPressed: _callQrCodeScan,texto: "Ler QR Code",),
   _paddingBotoes(),
   StartButton(onPressed: _redirecionarPagina,texto: "Iniciar Questionário",),
   _paddingBotoes(),
   Padding(
     padding: const EdgeInsets.only(bottom: 50),
     child: StartButton(onPressed: _redirecionarPagina,texto: "Método Disc",),
   )],);

_redirecionarPagina()=>Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => QuizPage()),
  (page) => false);


Padding _paddingBotoes()=>Padding(padding:EdgeInsets.only(top: 20));

_callQrCodeScan() async {
  QrCodeScanner().scan().then((returnScan){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ParticiparProjetoPage(chaveProjeto: _chaveProjeto(returnScan),)),
          (page) => false);});
  }
  _iniciarProjeto()=>Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ParticiparProjetoPage()),
          (page) => false);

String _chaveProjeto(String url){
  int i = url.lastIndexOf('=');
  String retorno = url.substring(i,url.length);
  return retorno;
}


          
}