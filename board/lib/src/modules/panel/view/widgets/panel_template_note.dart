import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/modules/panel/models/question.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/widgets/panel_template_item.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/widgets/panel_template_title_left.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/widgets/panel_template_title_rigth.dart';
import 'package:gabarite_board_cfc/src/shared/extension/extension_context.dart';

class PanelTemplateNote extends StatelessWidget {
  const PanelTemplateNote({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.questions,
    required this.typeNote,
  });

  final Color backgroundColor;
  final String title;
  final List<Question> questions;
  final TypeNote typeNote;

  @override
  Widget build(BuildContext context) {
    final config = context.gridView;

    return Row(
      children: [
        if (typeNote.isLeft)
          PanelTemplateTitleLeft(
            backgroundColor: backgroundColor,
            title: title,
          ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(
                width: 0,
                color: backgroundColor,
              ),
            ),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              padding: config.padding,
              itemCount: questions.length,
              gridDelegate: config.gridDelegate,
              itemBuilder: (context, index) {
                final question = questions[index];

                return PanelTemplateItem(
                  alternative: question.alternative,
                  index: index + 1,
                  isVisible: question.visible,
                  type: typeNote,
                );
              },
            ),
          ),
        ),
        if (typeNote.isRigth)
          PanelTemplateTitleRigth(
            backgroundColor: backgroundColor,
            title: title,
          ),
      ],
    );
  }
}
