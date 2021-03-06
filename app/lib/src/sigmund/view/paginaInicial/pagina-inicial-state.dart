import 'package:app/src/sigmund/resource/tipo-quiz.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/componentes/logo-image.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaInicialState extends State<PaginaInicialPage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context)=> _buildScaffold();

   _buildScaffold()=>
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
  children: <Widget>[Padding(
    padding: const EdgeInsets.only(top:50),
    child: LogoImage(height: 0.25,),
  ), Spacer(),_startButtons(),
  ],
);

 Column _startButtons()=> Column(children: <Widget>[
   StartButton(onPressed:()=>_callQrCodeScan(),texto: "Ler QR Code", ),
   _paddingBotoes(),
   StartButton(onPressed:()=>_iniciarProjeto(null),texto: "Participar Projeto",),
   _paddingBotoes(),
   StartButton(onPressed:()=> _redirecionarQuizSigmund(),texto: "Questionário Sigmund",),
   _paddingBotoes(),
   Padding(
     padding: const EdgeInsets.only(bottom: 50),
     child: StartButton(onPressed: _redirecionarQuizDisc,texto: "Questionário DISC",),
   )],);

_redirecionarQuizSigmund()=>Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => QuizPage(tipoQuiz: TipoQuiz.sigmund,)),
          (page) => false);

  _redirecionarQuizDisc()=>Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => QuizPage(tipoQuiz: TipoQuiz.disc,)),
          (page) => false);


Padding _paddingBotoes()=>Padding(padding:EdgeInsets.only(top: 20));

_callQrCodeScan() async {
    var result = await BarcodeScanner.scan();
    _iniciarProjeto(_chaveProjeto(result.rawContent));

  }

_iniciarProjeto(String chave)=>Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => ParticiparProjetoPage(chaveProjeto: chave,)),
          (page) => false);

String _chaveProjeto(String url){
  int i = url.lastIndexOf('=');
  i++;
  String retorno = url.substring(i,url.length);
  return retorno;
}
}