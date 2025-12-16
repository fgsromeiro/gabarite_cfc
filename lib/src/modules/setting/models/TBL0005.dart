class TBL0005 {
  final bool showButtons;

  TBL0005({required this.showButtons});

  factory TBL0005.fromMap(Map<String, dynamic> map) {
    return TBL0005(
      showButtons: map['showButtons'] ?? false,
    );
  }

  String get mapperBool => showButtons ? 'Habilitado' : 'Desabilitado';

  Map<String, dynamic> toMap() {
    return {
      'showButtons': showButtons,
    };
  }
}
