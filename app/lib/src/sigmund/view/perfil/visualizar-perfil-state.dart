import 'package:app/src/sigmund/helper/perfil-helper.dart';
import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/view/paginaInicial/pagina-inicial-page.dart';
import 'package:app/src/sigmund/view/perfil/visualizar-perfil-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class VisualizarPerfilState extends State<VisualizarPerfilPage> {

  Perfil perfil;

  VisualizarPerfilState({this.perfil});


  @override
  Widget  build(BuildContext context) {

    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return  ResponsiveWidgets.builder(
        // Optional
        child:WillPopScope(
            onWillPop: _onBackPressed,
                  child: Scaffold(
            body: Container(
              decoration: Constantes.BACKGROUND_GRADIENTE,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                      child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(top: 40, left: 20),
                        child: Text(
                          "O seu perfil é...",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  )),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsetsResponsive.only(top: 25),
                          child: Text(
                            PerfilHelper.getNome(perfil),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            child: Image.asset(PerfilHelper.getImagem(perfil),
                                height: MediaQuery.of(context).size.height *
                                    (Perfil.analista == perfil ? 0.22 : 0.3)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Center(
                            child: Text(
                              PerfilHelper.getDescricao(perfil),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil()
                                      .setSp(50)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _redirecionarPagina(),
            label: Text("Responder novamente"),
            backgroundColor: Constantes.ICON_COLOR,
            icon: Icon(MdiIcons.rotate3d),
            elevation: 10,
            hoverElevation: 5,
            foregroundColor: Colors.white,
          )),
        ));
  }

  _redirecionarPagina() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PaginaInicialPage()),
        (page) => false);
  }

   Future<bool>_onBackPressed(){
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PaginaInicialPage()),
        (page) => false) ??
      false;
      }
}
