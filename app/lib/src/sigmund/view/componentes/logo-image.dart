import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:flutter/widgets.dart';

class LogoImage extends StatelessWidget {
  final double height;

  LogoImage({this.height});

  @override
  Widget build(BuildContext context) => Image.asset(
    Constantes.ICONE_LOGO,
    height: MediaQuery.of(context).size.height * height,
  );
}