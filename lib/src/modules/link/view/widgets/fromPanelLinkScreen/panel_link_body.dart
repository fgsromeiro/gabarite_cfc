import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelLinkBody extends StatelessWidget {
  const PanelLinkBody({
    super.key,
    required this.controller,
  });

  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkBloc, LinkState>(
      builder: (context, state) {
        if (state.status.isLoaded && !state.isEmpty) {
          return ScrollablePositionedList.builder(
            itemScrollController: controller,
            itemCount: state.questionsFiltered.length,
            itemBuilder: (context, index) => PanelLinkCard(
              enable: !state.noteSelected!.isReference,
              question: state.questionsFiltered[index],
            ),
          );
        } else if (state.status.isLoaded && state.isFilteredAndEmpty) {
          return AppListEmpty(
            message: 'Revise os filtros e tente novamente',
          );
        } else if (state.status.isLoaded && state.isEmpty) {
          return AppListEmpty(
            message: 'Selecione um caderno para buscar as questões correspondentes',
          );
        } else if (state.status.isLoading) {
          return AppCircularIndicator();
        }
        return AppError(message: state.message!);
      },
    );
  }
}
