class StringConstants {
  static Map<int, String> mapperString = {
    1: 'Erro 503: Serviço indisponível. Erro ao mapear os dados.',
    2: 'Erro 504: Sem conexão com a internet. Verifique sua conexão e tente novamente.',
  };

  static String getString(int cod) => mapperString[cod] ?? '';
}
