import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardFormSmScreen extends StatelessWidget {
  const PanelBoardFormSmScreen({
    super.key,
    required this.question,
  });

  final TBL0003 question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(),
      body: PanelBoardSmFormBody(question: question),
    );
  }
}
