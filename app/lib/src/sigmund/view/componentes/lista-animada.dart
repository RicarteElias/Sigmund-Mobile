import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedListExample extends StatefulWidget {
  @override
  ListaAnimadaState createState() {
    return new ListaAnimadaState();
  }
}

class ListaAnimadaState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _respostas = [
    "Resposta 1",
    "Resposta 2",
    "Resposta 3",
    "Resposta 4",

  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Animated List'),
        backgroundColor: Colors.blueAccent,
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text(
            'Add an item',
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
        initialItemCount: _respostas.length,
        itemBuilder: (context, index, animation) => _buildItem(context, _respostas[index], animation),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = new TextStyle(fontSize: 20);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
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
    _respostas.insert(0, "WordPair.random().toString()");
  _listKey.currentState.insertItem(0);
}



  void _removeAllItems() {
    final int itemCount = _respostas.length;

    for (var i = 0; i < itemCount; i++) {
      String itemToRemove = _respostas[0];
      _listKey.currentState.removeItem(0,
            (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 2250),
      );

      _respostas.removeAt(0);
    }
  }
}


