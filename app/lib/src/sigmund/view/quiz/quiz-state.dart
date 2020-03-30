import 'dart:async';

import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Animation animation;
  Animation animationController;
  int count = 0 ;


  List<String> _respostas = [
    "Resposta ",
    "Resposta ",
    "Resposta ",
    "Resposta ",

  ];

  @override
  void initState(){
    super.initState();
    _adicionarRespostas();
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Pergunta'),
        backgroundColor: Constantes.ICON_COLOR,
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text(
            'Nova pergunta',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: ()  {
            _novaPergunta();
          },
        ),

        RaisedButton(
          child: Text(
            'Remover Todos',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            _removeAllItems();
          },
        ),
      ],
      body: AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        itemBuilder: (context, index, animation) => _buildItem(context, _respostas[index], animation),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = TextStyle(fontSize: 30, color: Colors.white);

    return Padding(
      padding: const EdgeInsets.only(top:30.0, left: 5, right: 5),
      child: ScaleTransition(
        scale: animation,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 50.0,
          child: Container(
            decoration: BoxDecoration(color: Constantes.ICON_COLOR,borderRadius: BorderRadius.circular(10),
            boxShadow:[BoxShadow(color: Colors.black)]
            ),
            child: Center(
                child:Text(item, style: textStyle)
            )
          ),
        ),
      ),
    );
  }

 _novaPergunta(){
    _removeAllItems();
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
    });

  }
  _adicionarRespostas(){

    for (var i = 0; i < 4; i++){
      _respostas.insert(0, "Resposta " + i.toString() );
      _listKey.currentState.insertItem(0);
    }

  }

Future <void> _removeAllItems() async {
    final int itemCount = _respostas.length;

    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _respostas[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 300),
      );

      _respostas.removeAt(0);
    }

  }




}


