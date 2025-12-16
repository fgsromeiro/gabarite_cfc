import '../../export/app_export.dart';

class AuthConfig {
  bool isVisibilityBanner;
  Axis direction;
  double percential;

  AuthConfig({this.isVisibilityBanner = true, this.direction = Axis.horizontal, this.percential = 0.55});
}
