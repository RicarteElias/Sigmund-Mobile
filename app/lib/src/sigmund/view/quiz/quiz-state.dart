import 'dart:async';
import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:app/src/sigmund/helper/perfil-helper.dart';
import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/resource/questionario-disc.dart';
import 'package:app/src/sigmund/resource/questionario-sigmund.dart';
import 'package:app/src/sigmund/resource/tipo-quiz.dart';
import 'package:app/src/sigmund/service/projeto-service.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/ultil/data-utils.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Projeto projeto;
  TipoQuiz tipoQuiz;
  static var _questionario;
  ProjetoService _projetoService = ProjetoService();


  bool _animationController;  //controller da animação

  List<String> _listaAnimada; //Lista para animação

  List<String> _novasRespostas;  //Lista com as respostas

  String _novaPergunta; //Texto da pergunta

  int _questaoController = 1;  //controller da questão

  bool _isButtonTapped = false; //controller pra impedir double tap na lista

  var _qtdeRespostas = [0, 0, 0, 0]; //lista com o número de escolhas

  bool _fadeTransitionController = true;//Controller da transição da pergunta

  List<String> _respostas = List<String>();//lista com as respostas

  //Construtor
   QuizState({this.projeto,this.tipoQuiz}){
     if(tipoQuiz==TipoQuiz.sigmund){
      _questionario = QuestionarioSigmund().questionario;
     }else{
       _questionario = QuestionarioDisc().questionario;
     }
  }

  @override
  void initState() {
    _novaPergunta = _questionario[0]['pergunta'].toString() + "...";
    _listaAnimada =  _questionario[0]['respostas'];
    _novasRespostas =  _questionario[1]['respostas'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: Constantes.BACKGROUND_GRADIENTE,
            child: Column(
              children: <Widget>[
                SizedBox(
                    child: Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 40, left: 10),
                      child: AnimatedOpacity(
                          opacity: _fadeTransitionController ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            _novaPergunta,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                )),
                Flexible(
                  child: AnimatedList(
                    shrinkWrap: true,
                    key: _listKey,
                    initialItemCount: _listaAnimada.length,
                    itemBuilder: (context, index, animation) => _buildItem(
                        context, _listaAnimada[index], animation, index),
                  ),
                ),
              ],
            )));
  }

  //Builder da lista
  Widget _buildItem(
      BuildContext context, String item, Animation<double> animation, index) {
    TextStyle textStyle = new TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: ScaleTransition(
          scale: animation,
          alignment: _animationController == true
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              if (_questaoController < DataUtils.sizeOfList(_questionario)) {
                // ignore: unnecessary_statements
                _isButtonTapped ? null : _proximaPergunta(index);
                setState(() {
                  _isButtonTapped = !_isButtonTapped;
                });
              } else {
                _qtdeRespostas[index]++;
                _respostas.add((index + 1).toString());
                _redirecionarPagina();
              }
            },
            child: SizedBox(
              height: 80,
              child: Container(
                  //Text(item,style: textStyle,)
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(68, 31, 84, 1.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                    color: Constantes.ICON_COLOR,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            item,
                            style: textStyle,
                          )),
                    ),
                  )),
            ),
          )),
    );
  }

  //Método para adicionar respostas a lista
  void _adicionarRespostas() {
    _animationController = true;
    for (var i = 0; i < 4; i++) {
      _listaAnimada.insert(0, _novasRespostas[i]);
      _listKey.currentState.insertItem(0);
    }
    _questaoController++;
    _questaoController == DataUtils.sizeOfList(_questionario)
        // ignore: unnecessary_statements
        ? null
        : _novasRespostas =
            _questionario[_questaoController]['respostas'];
    _questaoController == DataUtils.sizeOfList(_questionario)-1
        ? _novaPergunta = _questionario[_questaoController -1]['pergunta']
        .toString() +
        "..."
        : _novaPergunta = _questionario[_questaoController-1]['pergunta']
                .toString() +
            "...";
   }

  //Método para chamar a próxima pergunta
  _proximaPergunta(index) {
    setState(() => _fadeTransitionController = !_fadeTransitionController);
    _qtdeRespostas[index]++;
    if(tipoQuiz==TipoQuiz.sigmund){
      _respostas.add((index + 1).toString());
    }
    _removerRespotas();
    //Timer para sincronizar a animação da lista
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
      setState(() => _fadeTransitionController = !_fadeTransitionController);
      _isButtonTapped = false;
    });
  }

  //Método para esvaziar a lista
  void _removerRespotas() {
    _animationController = false;
    final int itemCount = _listaAnimada.length;
    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _listaAnimada[0];
      _listKey.currentState.removeItem(
        0,
        (BuildContext context, Animation<double> animation) =>
            _buildItem(context, itemToRemove, animation, null),
        duration: const Duration(milliseconds: 250),
      );
      _listaAnimada.removeAt(0);
    }
  }
  _redirecionarPagina() {
     Perfil perfil = PerfilHelper.getPerfil(_qtdeRespostas);
     if(!(projeto==null)){
     projeto.answers=_respostas;
     projeto.profile=PerfilHelper.getNome(perfil);
     _projetoService.participarProjeto(projeto);

     }

     print(_respostas);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => VisualizarPerfilPage(
                perfil: perfil,
                )),
        (page) => false);
  }
}
