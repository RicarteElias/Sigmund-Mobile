import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:app/src/sigmund/resource/tipo-quiz.dart';
import 'package:app/src/sigmund/view/quiz/quiz-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget{
  Projeto projeto;
  TipoQuiz tipoQuiz;
  @override
  State<StatefulWidget> createState() => QuizState(tipoQuiz: tipoQuiz,projeto: projeto);

  QuizPage({this.projeto,this.tipoQuiz});

}