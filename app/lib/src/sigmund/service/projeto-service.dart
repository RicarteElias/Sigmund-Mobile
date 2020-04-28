import 'package:app/src/sigmund/entity/projeto.dart';
import 'package:http/http.dart';

class ProjetoService {

final String url = 'https://jsonplaceholder.typicode.com/posts';
  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };


//nameStudent,email,chaveProjeto,profile,ansewrs


  Future <void> salvarProjeto(Projeto projeto) async {
   Response response = await post(url, headers: headers, body: projeto.toJson());

  }

}