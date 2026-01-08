import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class PanelBody extends StatefulWidget {
  const PanelBody({
    super.key,
    required this.questions,
  });

  final List<Question> questions;

  @override
  State<PanelBody> createState() => _PanelBodyState();
}

class _PanelBodyState extends State<PanelBody> {
  final GlobalKey _globalKeyPanel1 = GlobalKey();
  final GlobalKey _globalKeyPanel2 = GlobalKey();
  final GlobalKey _globalKeyPanel3 = GlobalKey();
  final GlobalKey _globalKeyPanel4 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final config = context.panel;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: context.sz.width * config.factorWidth,
            padding: EdgeInsets.all(AppInsets.sm),
            child: Column(
              spacing: AppSpacing.sm,
              children: [
                Expanded(
                  child: Flex(
                    direction: Axis.horizontal,
                    spacing: AppSpacing.sm,
                    children: [
                      Flexible(
                        child: RepaintBoundary(
                          key: _globalKeyPanel1,
                          child: PanelTemplateNote(
                            backgroundColor: context.colorScheme.primary,
                            title: 'TIPO 1',
                            questions: Utils.filterList(typeNote: TypeNote.typeOne, questions: widget.questions),
                            typeNote: TypeNote.typeOne,
                          ),
                        ),
                      ),
                      Flexible(
                        child: RepaintBoundary(
                          key: _globalKeyPanel2,
                          child: PanelTemplateNote(
                            backgroundColor: context.colorScheme.secondary,
                            title: 'TIPO 2',
                            questions: Utils.filterList(typeNote: TypeNote.typeTwo, questions: widget.questions),
                            typeNote: TypeNote.typeTwo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Flex(
                    spacing: AppSpacing.sm,
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        child: RepaintBoundary(
                          key: _globalKeyPanel3,
                          child: PanelTemplateNote(
                            backgroundColor: context.colorScheme.secondary,
                            title: 'TIPO 3',
                            questions: Utils.filterList(typeNote: TypeNote.typeTree, questions: widget.questions),
                            typeNote: TypeNote.typeTree,
                          ),
                        ),
                      ),
                      Flexible(
                          child: RepaintBoundary(
                        key: _globalKeyPanel4,
                        child: PanelTemplateNote(
                          backgroundColor: context.colorScheme.secondary,
                          title: 'TIPO 4',
                          questions: Utils.filterList(typeNote: TypeNote.typeFour, questions: widget.questions),
                          typeNote: TypeNote.typeFour,
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: PanelTemplateRecurse(),
                )
              ],
            ),
          ),
        ),
        BlocBuilder<PanelBloc, PanelState>(
          builder: (context, state) => Visibility(
            visible: state.showButtonsDownload,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: AppSpacing.sm,
                children: [
                  AppButton(
                    title: 'BAIXAR - TIPO 1',
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          _globalKeyPanel1.currentContext!.findRenderObject() as RenderRepaintBoundary;

                      final image = await boundary.toImage(pixelRatio: 3.0);

                      if (!context.mounted) return;

                      context.read<PanelBloc>().exportPanelToImage(image, 'quadro_tipo_1');
                    },
                    backgroundColor: context.colorScheme.tertiary,
                  ),
                  AppButton(
                    title: 'BAIXAR - TIPO 2',
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          _globalKeyPanel2.currentContext!.findRenderObject() as RenderRepaintBoundary;

                      final image = await boundary.toImage(pixelRatio: 3.0);

                      if (!context.mounted) return;

                      context.read<PanelBloc>().exportPanelToImage(image, 'quadro_tipo_2');
                    },
                    backgroundColor: context.colorScheme.tertiary,
                  ),
                  AppButton(
                    title: 'BAIXAR - TIPO 3',
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          _globalKeyPanel3.currentContext!.findRenderObject() as RenderRepaintBoundary;

                      final image = await boundary.toImage(pixelRatio: 3.0);

                      if (!context.mounted) return;

                      context.read<PanelBloc>().exportPanelToImage(image, 'quadro_tipo_3');
                    },
                    backgroundColor: context.colorScheme.tertiary,
                  ),
                  AppButton(
                    title: 'BAIXAR - TIPO 4',
                    onPressed: () async {
                      RenderRepaintBoundary boundary =
                          _globalKeyPanel4.currentContext!.findRenderObject() as RenderRepaintBoundary;

                      final image = await boundary.toImage(pixelRatio: 3.0);

                      if (!context.mounted) return;

                      context.read<PanelBloc>().exportPanelToImage(image, 'quadro_tipo_4');
                    },
                    backgroundColor: context.colorScheme.tertiary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
