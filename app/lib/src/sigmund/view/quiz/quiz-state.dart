import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuizState extends State<QuizPage> with SingleTickerProviderStateMixin{
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Animation animation;
  Animation animationController;


  List<String> _respostas = [
    "Resposta ",
    "Resposta ",
    "Resposta ",
    "Resposta ",

  ];

  @override
  void initState(){
    super.initState();

    animationController = AnimationController(duration: Duration(seconds: 2),vsync: this);
    animation = Tween(begin: -1.0, end:  0.0).animate(CurvedAnimation(
      parent: animationController,curve: Curves.fastOutSlowIn
    ));

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

 Future <void> _novaPergunta() async {
    await _removeAllItems();
    _adicionarRespostas();

  }

  void _adicionarRespostas(){
    
    final int itemCount = _respostas.length;
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


