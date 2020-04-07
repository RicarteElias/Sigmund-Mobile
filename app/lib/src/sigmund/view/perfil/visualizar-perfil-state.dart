import 'package:app/src/sigmund/resource/perfil-helper.dart';
import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualizarPerfilState extends State<VisualizarPerfilPage> {

  List<int> respostas;
  Perfil perfil;

  VisualizarPerfilState({this.respostas}){
    this.perfil = PerfilHelper.getPerfil(respostas);
  }

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
       body: Container(
           decoration: Constantes.BACKGROUND_GRADIENTE,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               SizedBox(child:
                  Container(child:  Padding(padding: EdgeInsets.only(top: 40,left: 20),
                   child:Text("O seu perfil é...",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white),)
               ),)),
                        Center(
                        child: Column(
                          children: <Widget>[ Padding(padding: EdgeInsets.only(top: 50),child:
                          Text(PerfilHelper.getNome(perfil),style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white)
                            ,)
                            ,)
                          ,Padding(padding: EdgeInsets.only(top: 20),child: 
                              SizedBox(

                                child: Image.asset(PerfilHelper.getImagem(perfil),
                                    height: MediaQuery.of(context).size.height * (Perfil.analista==perfil?0.22:0.3)),
                              ),),
                        ],
                        ),
               )
             ],
           )
       )
   );
  }
}