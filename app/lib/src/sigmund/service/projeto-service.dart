import 'dart:convert';

import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:dio/dio.dart';


class ProjetoService {

final String url = 'http://projetosacademico.com.br:5000/projects/imm587425';
  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };

Dio dio = new Dio();

//nameStudent,email,chaveProjeto,profile,ansewrs


  Future <void> participarProjeto(Projeto projeto) async {
    dio.options.baseUrl ="http://projetosacademico.com.br:5000";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    Response response = await dio.get("/login", queryParameters: {"email": projeto.email, "chaveProjeto": projeto.chaveProjeto});
    Map<String, dynamic> resposta = jsonDecode(response.toString());

    if(resposta['success']){
    response = await dio.post("/students", data:projeto.toJson());
    print(response.data.toString());
    }else{
       throw resposta['warning'];
    } 
     
  }

}