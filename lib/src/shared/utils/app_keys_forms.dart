import '../export/app_export.dart';

class AppKeysForms {
  static final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  static GlobalKey<FormState> get formLoginKey => _formLoginKey;
  static GlobalKey<FormState> get formRegisterKey => _formRegisterKey;
}
