import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage>{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _respostas = [
    "Resposta ",
    "Resposta ",
    "Resposta ",
    "Resposta ",

  ];
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
        initialItemCount: _respostas.length,
        itemBuilder: (context, index, animation) => _buildItem(context, _respostas[index], animation),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = TextStyle(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.only(top:20.0, left: 2, right: 2),
      child: ScaleTransition(
        scale: animation,
        alignment: Alignment.centerLeft,
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

  void _novaPergunta() {
    _removeAllItems();
    _adicionarRespostas();

  }

  void _adicionarRespostas(){
    final int itemCount = _respostas.length;
    for (var i = 0; i < 4; i++){
      _respostas.insert(0, "Resposta " + i.toString() );
      _listKey.currentState.insertItem(0);
    }

  }

void _removeAllItems() {
    final int itemCount = _respostas.length;

    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _respostas[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 250),
      );

      _respostas.removeAt(0);
    }
  }
}


