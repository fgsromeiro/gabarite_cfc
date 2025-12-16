// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/shared/extension/extension_context.dart';
import 'package:gabarite_board_cfc/src/theme/app_fonts.dart';

class PanelTemplateTitleRigth extends StatelessWidget {
  const PanelTemplateTitleRigth({
    super.key,
    required this.backgroundColor,
    required this.title,
  });

  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sz.width * 0.030,
      height: context.sz.height * 0.20,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 0, color: backgroundColor),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            title,
            style: context.theme.textTheme.headlineLarge!.copyWith(
              color: context.colorScheme.onTertiary,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.stem,
            ),
          ),
        ),
      ),
    );
  }
}
