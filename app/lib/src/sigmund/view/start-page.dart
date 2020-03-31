import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    //bloquear giro de tela
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sigmund',
      home: PaginaInicialPage(),
    );
  }
}