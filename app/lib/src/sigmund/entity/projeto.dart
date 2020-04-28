import 'package:json_annotation/json_annotation.dart';
part 'projeto.g.dart';

@JsonSerializable()

//nameStudent,email,chaveProjeto,profile,ansewrs

class Projeto{


  String nameStudent;
  String email;
  String chaveProjeto;
  String profile;
  List<int> answers;

  Projeto({this.chaveProjeto,this.email,this.answers,this.nameStudent,this.profile});

  factory Projeto.fromJson(Map<String, dynamic> json) => _$ProjetoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjetoToJson(this);

}