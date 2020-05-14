import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:app/src/sigmund/resource/tipo-quiz.dart';
import 'package:app/src/sigmund/service/exceptions/projeto-exception.dart';
import 'package:app/src/sigmund/service/projeto-service.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';
import 'package:app/src/sigmund/ultil/data-utils.dart';
import 'package:app/src/sigmund/view/componentes/botao-pagina-inicial.dart';
import 'package:app/src/sigmund/view/participarprojeto/participar-projeto-page.dart';
import 'package:app/src/sigmund/view/quiz/quiz-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ParticiparProjetoState extends State<ParticiparProjetoPage>{

  String chaveProjeto;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey();

  //controllers
  final _emailController=TextEditingController();
  final _nomAlunoController= TextEditingController();
  final _chaveProjetoController= TextEditingController();
  ProjetoService _projetoService= new ProjetoService();
  bool _validate = false;

   
   //Construtor
   ParticiparProjetoState({this.chaveProjeto});
  
  @override
  void initState() {
    if(DataUtils.isNotEmpty(this.chaveProjeto)){
      _chaveProjetoController.text = chaveProjeto;
      
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height *1,
                decoration: Constantes.BACKGROUND_GRADIENTE,
                child: formulario(),
        ),
      ),
    );
  }
  Form formulario() => Form(
    key: _formKey,
    autovalidate: _validate,
    child: Container(
      margin: EdgeInsets.all(13),
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
      validator: _validarNome,
      style: _texFormFieldStyle(),
      controller: _nomAlunoController,
      decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.face,color: Colors.white,),
        labelStyle: _labelStyle(),
        labelText: 'Nome',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(style: BorderStyle.solid))
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child:TextFormField(
        validator:_validarEmail,
        keyboardType: TextInputType.emailAddress,
        style:_texFormFieldStyle() ,
        controller:_emailController ,
        decoration: InputDecoration(
          prefixIcon:Icon(MdiIcons.email,color: Colors.white,) ,
          focusColor: Colors.white,
          labelStyle: _labelStyle(),
          labelText: 'E-mail', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(style: BorderStyle.solid))
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        style: _texFormFieldStyle(),
        controller: _chaveProjetoController,
        decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.key,color: Colors.white,),
        labelStyle: _labelStyle(),
          labelText: 'Chave projeto',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(style: BorderStyle.solid))
      ),
    ),
    ),
    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.10),child:
   StartButton(texto: "Iniciar questionário",onPressed: _validarCampos,),),
    ],
  );

  _labelStyle()=>TextStyle(color: Colors.white, fontSize: 20);
  _texFormFieldStyle()=>TextStyle(color: Colors.white,fontSize: 20);

  _iniciarQuestionario(){
    Projeto projeto = Projeto(nameStudent:_nomAlunoController.text.trim(),
        email: _emailController.text.trim(),
        chaveProjeto: _chaveProjetoController.text.trim());
      _projetoService.validarParticipacao(projeto).then((onValue){
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => QuizPage(projeto:
      projeto,tipoQuiz: TipoQuiz.sigmund,)),(page) => false);
      }).catchError((erro){
        ProjetoException e = erro;
        _apresentarMensagem(mensagem: e.mensagem,background: Colors.red);
      });
  }

  _apresentarMensagem( {String mensagem, Color background}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        mensagem,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: Constantes.TIME_MESSAGE),
      backgroundColor: background,
    ));
  }
 

String _validarEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if(!regExp.hasMatch(value)){
      return "Email inválido";
    }else {
      return null;
    }
  }
  String _validarNome(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }


  _validarCampos(){
    if (_formKey.currentState.validate()) {
    _iniciarQuestionario();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}