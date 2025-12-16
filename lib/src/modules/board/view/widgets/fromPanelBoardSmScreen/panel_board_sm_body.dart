import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardSmBody extends StatefulWidget {
  const PanelBoardSmBody({super.key});

  @override
  State<PanelBoardSmBody> createState() => _PanelBoardSmBodyState();
}

class _PanelBoardSmBodyState extends State<PanelBoardSmBody> {
  String? searchText;
  FilterQuestion filterQuestion = FilterQuestion.all;

  void resetSearch() {
    setState(() => searchText = null);
    context.read<BoardBloc>().search('');
  }

  void resetFilter() {
    setState(() {
      filterQuestion = FilterQuestion.all;
    });
    context.read<BoardBloc>().filterBy(FilterQuestion.all);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppInsets.med),
      margin: EdgeInsets.only(
        bottom: AppInsets.sm,
        left: AppInsets.sm,
        right: AppInsets.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: context.colorScheme.onSecondaryFixedVariant,
        ),
      ),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          AppHeader(
            spacing: AppSpacing.sm,
            title: 'Realizar Correção',
            description:
                'Edite as questões do caderno de referência. As alterações serão sincronizadas com as questões vinculadas em outros cadernos.',
          ),
          2.h,
          SizedBox(
            height: context.sz.height * 0.06,
            child: Flex(
              direction: Axis.horizontal,
              spacing: AppSpacing.xs,
              children: [
                Flexible(
                    child: PanelBoardSmButton(
                        showBadge: searchText.isNotNull,
                        onTap: () {
                          Dialogs.showDialogSearch(context, searchText).then((value) {
                            if (value != null && value.isNotEmpty) {
                              if (!context.mounted) return;
                              setState(() => searchText = value);
                              context.read<BoardBloc>().search(value);
                            } else {
                              resetSearch();
                            }
                          });
                        },
                        icon: Icons.search)),
                Flexible(
                  child: PanelBoardSmButton(
                    showBadge: filterQuestion != FilterQuestion.all,
                    onTap: () {
                      Dialogs.showDialogFilter(context, filterQuestion).then((value) {
                        if (value != null) {
                          if (!context.mounted) return;
                          setState(() => filterQuestion = value);
                          context.read<BoardBloc>().filterBy(value);
                        } else {
                          resetFilter();
                        }
                      });
                    },
                    icon: Icons.filter_list,
                  ),
                ),
                Flexible(
                  child: BlocBuilder<BoardBloc, BoardState>(
                    builder: (context, state) => PanelBoardSmBoxInfo(text: '${state.countAwnsered}/50'),
                  ),
                ),
              ],
            ),
          ),
          AppDivider(showPoint: false),
          Expanded(child: PanelBoardSmList()),
        ],
      ),
    );
  }
}
