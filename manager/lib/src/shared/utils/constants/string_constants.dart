class StringConstants {
  static Map<int, String> mapperString = {
    1: 'Serviço indisponível. Erro ao mapear os dados.',
    2: 'Sem conexão com a internet. Verifique sua conexão e tente novamente.',
    3: 'Sessão expirada. Faça login novamente.',
    4: 'Verifique suas credenciais e tente novamente.',
    5: 'Erro interno do servidor. Tente novamente mais tarde.',
    6: 'Erro ao acessar o armazenamento. Tente novamente mais tarde.',
    7: 'Erro de autenticação. Tente novamente mais tarde.',
  };

  static String getString(int cod) => mapperString[cod] ?? '';

  static const String empty = '';
}
