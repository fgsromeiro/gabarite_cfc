import 'package:gabarite_cfc/src/modules/link/view/widgets/fromPanelLinkSmScreen/panel_link_sm_list.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelLinkSmBody extends StatefulWidget {
  const PanelLinkSmBody({super.key});

  @override
  State<PanelLinkSmBody> createState() => _PanelLinkSmBodyState();
}

class _PanelLinkSmBodyState extends State<PanelLinkSmBody> {
  TBL0001? _selectedNote;
  String? searchText;

  void resetSearch() {
    setState(() => searchText = null);
    context.read<LinkBloc>().search('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkBloc, LinkState>(
      builder: (context, state) {
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
                title: 'Vínculos de Questões',
                description:
                    'Selecione uma questão de cada lado para criar um vínculo. Cada questão de referência só pode ter um vínculo por caderno.',
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
                        onTap: () {
                          Dialogs.showDialogSearch(context, searchText).then((value) {
                            if (value != null && value.isNotEmpty) {
                              if (!context.mounted) return;
                              setState(() => searchText = value);
                              context.read<LinkBloc>().search(value);
                            } else {
                              resetSearch();
                            }
                          });
                        },
                        showBadge: searchText.isNotNull,
                        icon: Icons.search,
                      ),
                    ),
                    Flexible(
                      child: PanelBoardSmButton(
                        showBadge: _selectedNote.isNotNull,
                        onTap: () {
                          Dialogs.showDialogNotes(context, _selectedNote).then((note) {
                            if (note.isNull || !context.mounted) return;
                            setState(() {
                              _selectedNote = note;
                              searchText = null;
                            });
                            context.read<LinkBloc>().loadQuestionsByNote(note!);
                          });
                        },
                        icon: Icons.class_,
                      ),
                    ),
                    Flexible(
                      child: PanelBoardSmBoxInfo(text: '${state.countLinked}/50'),
                    ),
                  ],
                ),
              ),
              if (_selectedNote.isNotNull)
                Text(
                  _selectedNote!.title.toUpperCase(),
                  style: context.theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              AppDivider(showPoint: false),
              Expanded(child: PanelLinkSmList()),
            ],
          ),
        );
      },
    );
  }
}
