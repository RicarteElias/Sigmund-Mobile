import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticiparProjetoState extends State<ParticiparProjetoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      decoration: InputDecoration(
        labelStyle: _labelStyle(),
          labelText: 'Código projeto',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 10),
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
  _iniciarQuestionario()=>print('teste');g


}