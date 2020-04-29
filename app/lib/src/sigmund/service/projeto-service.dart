import 'dart:convert';

import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:dio/dio.dart';

import 'exceptions/projeto-exception.dart';


class ProjetoService {

  final String url = 'http://projetosacademico.com.br:5000/projects/imm587425';
  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  Dio dio = new Dio();

  //Construtor
    ProjetoService(){
    dio.options.baseUrl ="http://projetosacademico.com.br:5000";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
  }

  Future <void> validarParticipacao(Projeto projeto) async {

    Response response = await dio.get("/login", queryParameters: {"email": projeto.email, "chaveProjeto": projeto.chaveProjeto});
    Map<String, dynamic> resposta = jsonDecode(response.toString());
    if(!resposta['success']){
    throw ProjetoException(resposta['warning']);
    }
  }

  Future<void> participarProjeto(Projeto projeto) async {
    Response response = await dio.post("/students", data:projeto.toJson());
    print(projeto);
    print(response.data.toString());
  }

}