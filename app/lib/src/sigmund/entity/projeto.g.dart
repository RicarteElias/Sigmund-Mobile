// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projeto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projeto _$ProjetoFromJson(Map<String, dynamic> json) {
  return Projeto(
    chaveProjeto: json['chaveProjeto'] as String,
    email: json['email'] as String,
    answers: (json['answers'] as List)?.map((e) => e as int)?.toList(),
    nameStudent: json['nameStudent'] as String,
    profile: json['profile'] as String,
  );
}

Map<String, dynamic> _$ProjetoToJson(Projeto instance) => <String, dynamic>{
      'nameStudent': instance.nameStudent,
      'email': instance.email,
      'chaveProjeto': instance.chaveProjeto,
      'profile': instance.profile,
      'answers': instance.answers,
    };
