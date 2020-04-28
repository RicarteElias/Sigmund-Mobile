import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:app/src/sigmund/service/projeto-service.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticiparProjetoState extends State<ParticiparProjetoPage>{
  final _emailController=TextEditingController();
  final _nomAlunoController= TextEditingController();
  final _chaveProjetoController= TextEditingController();
  ProjetoService _projetoService= new ProjetoService();
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: Constantes.BACKGROUND_GRADIENTE,
        child: formulario(),
      ),
    );
  }
  Form formulario() => Form(
    child: Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Padding(
              child: componentsFormularioLogin(),
              padding: EdgeInsets.only(top: 35),
            ),
          ),
        ],
      ),
    ),
  );

  Column componentsFormularioLogin() => Column(children: <Widget>[
    TextFormField(
      controller: _nomAlunoController,
      decoration: InputDecoration(
        labelStyle: _labelStyle(),
        labelText: 'Nome',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 10),
  borderRadius: BorderRadius.circular(20),
  )
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child:TextFormField(
        controller:_emailController ,
        decoration: InputDecoration(
          labelStyle: _labelStyle(),
          labelText: 'E-mail', border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 10),
          borderRadius: BorderRadius.circular(20),
          )
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextField(
        controller: _chaveProjetoController,
      decoration: InputDecoration(
        labelStyle: _labelStyle(),
          labelText: 'Chave projeto',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 10),
        borderRadius: BorderRadius.circular(20),
        )
      ),
    ),
    ),
    Padding(padding: EdgeInsets.only(top: 20),child:
      StartButton(texto: "Iniciar questionário",onPressed: _iniciarQuestionario,),)
    ],
  );

  _labelStyle()=>TextStyle(color: Colors.white,fontSize: 15);

  _iniciarQuestionario(){
    Projeto projeto = Projeto(nameStudent:_nomAlunoController.text.trim(),email: _emailController.text.trim(), chaveProjeto: _chaveProjetoController.text.trim());
    projeto.profile = "Analista";
    projeto.answers=['1','1','1','1','1','1','1','1','1','1','1','1'];

    try{
      _projetoService.participarProjeto(projeto);
      }catch(e){
        print(e);
        _apresentarMensagem(mensagem:e.toString(),background: Colors.red);
    }

    //Navigator.of(context).pushAndRemoveUntil(
      //MaterialPageRoute(builder: (context) => QuizPage(projeto:
      //projeto,)),
        //  (page) => false);
  }
 void _apresentarMensagem( {String mensagem, Color background}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        mensagem,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: Constantes.TIME_MESSAGE),
      backgroundColor: background,
    ));
  }


}