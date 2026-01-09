import '../shared/export/app_export.dart';

class AppShadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
          color: Colors.black.withAlpha(40),
          spreadRadius: 2,
          blurRadius: 6,
          offset: Offset(0, 0),
        ),
      ];
}
