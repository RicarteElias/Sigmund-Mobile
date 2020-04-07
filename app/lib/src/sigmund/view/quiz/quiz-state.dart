import 'dart:async';
import 'package:app/src/sigmund/resource/questionario.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  //controller da animação
  bool _animationController;
  //Lista para animação
  List<String> _listaAnimada = Questionario().questionario[0]['respostas'];
  //Lista com as respostas
  List<String> _novasRespostas = Questionario().questionario[1]['respostas'];
  //Texto da pergunta
  String novaPergunta = Questionario().questionario[0]['pergunta'].toString()+ "..." ;
  //controller da questão
  int _questaoController = 1 ;
  //controller pra impedir double tap na lista
  bool _isButtonTapped = false;
  //lista com o numero de escolhas
  var qtdeRespostas = [0,0,0,0];
  bool _fadeTransitionController = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Constantes.BACKGROUND_GRADIENTE,
        child: Column(
          children: <Widget>[
            SizedBox(child:
             Container(child:  Padding(padding: EdgeInsets.only(top: 40,left: 10),
                 child:
                 AnimatedOpacity(opacity: _fadeTransitionController? 1.0:0.0, duration: Duration(milliseconds: 300),child:
                  Text(novaPergunta,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white),))
             ),)),
            Flexible(
                          child: AnimatedList(
                shrinkWrap: true,
          key: _listKey,
          initialItemCount: _listaAnimada.length,
          itemBuilder: (context, index, animation) => _buildItem(context, _listaAnimada[index], animation,index),
        ),
            ),
      ],
        )
      )
    );
  }

  //Builder da lista
  Widget _buildItem(BuildContext context, String item, Animation<double> animation,index) {
    TextStyle textStyle = new TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top:30,left: 10,right: 10),
      child: ScaleTransition(
        scale: animation,
        alignment:_animationController==true?Alignment.centerRight:Alignment.centerLeft,
        child: GestureDetector(
          onTap: (){
            if(_questaoController < 25){
              // ignore: unnecessary_statements
              _isButtonTapped?null:_proximaPergunta(index);
              setState(() {
                _isButtonTapped = !_isButtonTapped;
              });
            }else{
              qtdeRespostas[index]++;
              print(qtdeRespostas);
              _redirecionarPagina();

            }
          },child: SizedBox(
            height: 80,
              child:  Container(
                //Text(item,style: textStyle,)
                decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color.fromRGBO(68, 31, 84, 1.0), blurRadius: 10,spreadRadius: 3)],
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),color: Constantes.ICON_COLOR,),
                child: Padding(padding: EdgeInsets.all(10),
                  child:Container(child: Padding(padding: EdgeInsets.only(top: 5),child: Text(item,style: textStyle,)
                    ),
                  ),
                )
          ),
        ),
        )
      ),
    );
  }
  //Método para adicionar respostas a lista
  void _adicionarRespostas() {
    _animationController=true;
    for(var i=0;i<4;i++) {
      _listaAnimada.insert(0, _novasRespostas[i]);
      _listKey.currentState.insertItem(0);
    }
    _questaoController++;
    _questaoController==25?null:_novasRespostas = Questionario().questionario[_questaoController]['respostas'];
    _questaoController==24?null:novaPergunta = Questionario().questionario[_questaoController -1 ]['pergunta'].toString() +"...";

  }

  //Método para chamar a próxima pergunta
    _proximaPergunta(index){
     setState(() => _fadeTransitionController = !_fadeTransitionController);
    qtdeRespostas[index]++;
    print(qtdeRespostas);
    _removerRespotas();
    //Timer para sincronizar a animação da lista
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
      setState(()=>_fadeTransitionController = !_fadeTransitionController);
      _isButtonTapped = false;
    });
  }
  //Método para esvaziar a lista
  void _removerRespotas() {
    _animationController=false;
    final int itemCount = _listaAnimada.length;
    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _listaAnimada[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation, null),
        duration: const Duration(milliseconds: 250),
      );
      _listaAnimada.removeAt(0);
    }
  }

  _redirecionarPagina(){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=> VisualizarPerfilPage(respostas: qtdeRespostas,)), (page)=>false);
  }
}





