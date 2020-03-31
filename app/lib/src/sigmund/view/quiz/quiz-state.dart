import 'dart:async';

import 'package:app/src/sigmund/model/entity/questionario.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool _animationController= true;

  List<String> _data = Questionario.questionario[0]['respostas'];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pergunta'),
        backgroundColor: Constantes.ICON_COLOR,
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text(
            'Próxima Pergunta',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            _novaPergunta();
          },
        ),

        RaisedButton(
          child: Text(
            'Remove all',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            _removeAllItems();
          },
        ),
      ],
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) => _buildItem(context, _data[index], animation),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = new TextStyle(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
        scale: animation,
        alignment:_animationController==true?Alignment.centerLeft:Alignment.centerRight,
        child: SizedBox(
          height: 50.0,
          child: Card(
            child: Center(
              child: Text(item, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }

  void _adicionarRespostas() {
    _removeAllItems();
    _animationController=true;
    int i = 0;
  while(i<4) {
    _data.insert(0, "testes");
    _listKey.currentState.insertItem(0);
    i++;
  }
  }

  _novaPergunta(){
    _removeAllItems();
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
    });
  }

  void _removeAllItems() {
    _animationController=false;
    final int itemCount = _data.length;
    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _data[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 250),
      );

      _data.removeAt(0);
    }
  }
}





