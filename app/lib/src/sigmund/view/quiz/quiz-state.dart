import 'dart:async';
import 'package:app/src/sigmund/model/entity/questionario.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      appBar: AppBar(
        title: Text(_novaPergunta,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Constantes.ICON_COLOR,
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constantes.ICON_COLOR,
        icon: Icon(MdiIcons.arrowRightBold),
        label: Text("Próxima pergunta",style: TextStyle(fontSize: 20),),
        onPressed: (){
          _proximaPergunta();
        },
      ),

      body: Container(
        decoration: Constantes.BACKGROUND_GRADIENTE,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _listaAnimada.length,
          itemBuilder: (context, index, animation) => _buildItem(context, _listaAnimada[index], animation),
        ),
      )
    );
  }

  //Builder da lista
  Widget _buildItem(BuildContext context, String item, Animation<double> animation) {
    TextStyle textStyle = new TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top:20,left: 10,right: 10),
      child: ScaleTransition(
        scale: animation,
        alignment:_animationController==true?Alignment.centerLeft:Alignment.centerRight,
        child: SizedBox(
          height: 90,
          child:  Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color.fromRGBO(68, 31, 84, 1.0), blurRadius: 10,spreadRadius: 3)],
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),color: Constantes.ICON_COLOR,),
              child: Padding(padding: EdgeInsets.all(10),
                child:Container(child: Text(item,style: textStyle,)),)
          ),
        ),
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
    _novasRespostas = Questionario().questionario[_questaoController]['respostas'];
    _novaPergunta = Questionario().questionario[_questaoController -1 ]['pergunta'].toString();
    setState(() {
    });
  }

  //Método para chamar a próxima pergunta
    _proximaPergunta(){
    _removerRespotas();
    //Timer para sincronizar a animação da lista
    Timer(Duration(milliseconds: 300), () {
      _adicionarRespostas();
    });

  }

  //Método para esvaziar a lista
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





