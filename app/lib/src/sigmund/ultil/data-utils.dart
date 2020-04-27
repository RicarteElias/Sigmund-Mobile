

/// Classe para facilitar o tratamento dos dados
class DataUtils {
  static String getEmptyStringIfNullable(String data) {
    if (data == null) return "";
    return data;
  }

  static int sizeOfList(List<dynamic> lista) {
    return lista == null ? 0 : lista.length;
  }


  static bool isEmpty(String texto) {
    return texto == null || texto.isEmpty;
  }

  static bool isNotEmpty(String texto) {
    return !isEmpty(texto);
  }



  static String toUpperCase(String text) {
    if (text == null) return "";
    return text.toUpperCase();
  }


}
