import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:nice_button/NiceButton.dart';

class StartButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String texto;


  const StartButton({Key key, this.onPressed, this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) =>NiceButton(width: MediaQuery.of(context).size.height * 0.50,
    elevation: 8.0,
    radius: 52.0,
    text: texto,
    background: Constantes.ICON_COLOR,
    onPressed: this.onPressed
  );

}