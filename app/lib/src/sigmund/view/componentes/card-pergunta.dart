import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Adicionar classe
class CardResposta{
  Widget cardResposta(item,textStyle) => Container(
  decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 1.0, style: BorderStyle.solid),
  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),color: Constantes.ICON_COLOR,),
  child: Padding(padding: EdgeInsets.all(10),
  child:Container(child: Text(item,style: textStyle,)),)
  );
}