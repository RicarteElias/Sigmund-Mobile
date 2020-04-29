import 'dart:math';
import 'package:app/src/sigmund/resource/perfil.dart';
import 'package:app/src/sigmund/ultil/constantes.dart';

class PerfilHelper {
  static Perfil getPerfil(List<int> respostas) {
    respostas[0] = respostas[0] * 4;
    respostas[1] = respostas[1] * 4;
    respostas[2] = respostas[2] * 4;
    respostas[3] = respostas[3] * 4;

    int perfil = respostas.indexOf(respostas.reduce(max));
    switch (perfil) {
      case 0:
        {
          return Perfil.analista;
        }
      case 1:
        {
          return Perfil.comunicador;
        }
      case 2:
        {
          return Perfil.executor;
        }
      default:
        {
          return Perfil.planejador;
        }
    }
  }

  // ignore: missing_return
  static String getNome(Perfil perfil) {
    switch (perfil) {
      case Perfil.analista:
        return "Analista";
      case Perfil.comunicador:
        return "Comunicador";
      case Perfil.executor:
        return "Executor";
      case Perfil.planejador:
        return "Planejador";
    }
  }

  // ignore: missing_return
  static String getImagem(Perfil perfil) {
    switch (perfil) {
      case Perfil.analista:
        return Constantes.IMAGE_ANALISTA;
      case Perfil.comunicador:
        return Constantes.IMAGE_COMUNICADOR;
      case Perfil.executor:
        return Constantes.IMAGE_EXECUTOR;
      case Perfil.planejador:
        return Constantes.IMAGE_PLANEJADOR;
    }
  }

  // ignore: missing_return
  static String getDescricao(Perfil perfil) {
    switch (perfil) {
      case Perfil.analista:
        return "Você é uma pessoa detalhista e "
            "meticulosa, a pessoa analista é organizada, "
            "responsável e altamente conservadora, "
            "sendo hábil ao controlar processos e "
            "rotinas repetitivas.";
      case Perfil.comunicador:
        return "Você é uma pessoa comunicativa e geralmente "
            "dotada de grande carisma e poder de "
            "persuasão e também uma pessoa sempre entusiasmada com "
            "projetos e novidades, tende a ser muito otimista e relaciona-se com facilidade.";
      case Perfil.executor:
        return "Você é uma pessoa dotada de extrema autoconfiança, "
            "esse tipo de pessoa é dominante e em casos extremos, pode "
            "ser autoritária e ditatorial, aceita e se dá bem com desafios "
            "e dificuldades, possui senso de competitividade extremo e costuma "
            "ser corajoso em suas posturas e ao defender seus pontos de vista.";
      case Perfil.planejador:
        return "Você é uma pessoa estável e paciente, de ritmo constante "
            "e alto grau de conservadorismo, dificilmente entra em "
            "pânico e tem uma pequena capacidade de improviso.";
    }
  }
}
