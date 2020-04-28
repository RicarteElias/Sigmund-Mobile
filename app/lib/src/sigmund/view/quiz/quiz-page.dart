import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:app/src/sigmund/view/quiz/quiz-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget{
  Projeto projeto;
  @override
  State<StatefulWidget> createState() => QuizState();

  QuizPage({this.projeto});

}