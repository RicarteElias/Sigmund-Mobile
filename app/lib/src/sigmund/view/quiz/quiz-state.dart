import 'dart:async';
import 'package:app/src/sigmund/model/entity/questionario.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool _animationController;
  List<String> _listaAnimada = Questionario().questionario[0]['respostas'];
  List<String> _novasRespostas = Questionario().questionario[1]['respostas'];
  String _novaPergunta = Questionario().questionario[0]['pergunta'];
  int _questaoController = 1;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_novaPergunta),
        backgroundColor: Constantes.ICON_COLOR,
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text(
            'Próxima Pergunta',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            _proximaPergunta();
          },
        ),

       ],
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _listaAnimada.length,
        itemBuilder: (context, index, animation) => _buildItem(context, _listaAnimada[index], animation),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = new TextStyle(fontSize: 22,color: Colors.white);

    return Padding(
      padding: const EdgeInsets.only(top:20,left: 5,right: 5),
      child: ScaleTransition(
        scale: animation,
        alignment:_animationController==true?Alignment.centerLeft:Alignment.centerRight,
        child: SizedBox(
          height: 90,
          child:  Container(
              decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),color: Constantes.ICON_COLOR,),
              child: Padding(padding: EdgeInsets.all(10),
                child:Container(child: Text(item,style: textStyle,)),)
          ),

        ),
      ),
    );
  }

  void _adicionarRespostas() {
    _animationController=true;
    for(var i=0;i<4;i++) {
      _listaAnimada.insert(0, _novasRespostas[i]);
      _listKey.currentState.insertItem(0);
    }
    _questaoController++;
    _novasRespostas = Questionario().questionario[_questaoController]['respostas'];
    _novaPergunta = Questionario().questionario[_questaoController -1 ]['pergunta'].toString();
    setState(() {
    });
  }

  _proximaPergunta(){
    _removerRespotas();
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
    });

  }

  void _removerRespotas() {
    _animationController=false;
    final int itemCount = _listaAnimada.length;
    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _listaAnimada[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 250),
      );
      _listaAnimada.removeAt(0);
    }
  }
}





