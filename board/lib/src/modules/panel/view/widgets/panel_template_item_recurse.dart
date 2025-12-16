// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/widgets/panel_mixin.dart';
import 'package:gabarite_board_cfc/src/shared/extension/extension_context.dart';
import 'package:gabarite_board_cfc/src/theme/app_fonts.dart';

class PanelTemplateRecurse extends StatelessWidget with PanelMixin {
  const PanelTemplateRecurse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          width: 45,
          decoration: BoxDecoration(
            color: context.colorScheme.onTertiary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colorScheme.error),
          ),
          child: Text(
            buildAlternative('RECURSO'),
            style: context.theme.textTheme.headlineLarge!.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.stemLight,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'RECURSO',
          style: context.theme.textTheme.titleMedium!.copyWith(
            color: context.colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.stemLight,
          ),
        ),
      ],
    );
  }
}
