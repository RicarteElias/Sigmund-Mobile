import 'package:app/src/sigmund/view/participarprojeto/particpar-projeto-state.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class ParticiparProjetoPage extends StatefulWidget{
  String chaveProjeto;
  ParticiparProjetoPage({this.chaveProjeto});

  @override
  State<StatefulWidget> createState() => ParticiparProjetoState(chaveProjeto: chaveProjeto);

}