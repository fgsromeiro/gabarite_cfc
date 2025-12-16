import '../../../../shared/export/app_export.dart';

class SettingsPanelBody extends StatefulWidget {
  const SettingsPanelBody({super.key});

  @override
  State<SettingsPanelBody> createState() => _SettingsPanelBodyState();
}

class _SettingsPanelBodyState extends State<SettingsPanelBody> {
  late final SettingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SettingBloc>();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final noteState = context.watch<NoteBloc>().state;
    final mobile = context.isMobile;
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state.status.isError) {
          Dialogs.showDialogMessage(
            context,
            message: state.message!,
            color: context.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return Expanded(child: Center(child: AppCircularIndicator()));
        }
        return Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.sm,
          children: [
            Flex(
              direction: mobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppInsets.med,
              children: [
                Text(
                  'Selecionar caderno como referência',
                  style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
                ),
                SizedBox(
                  width: context.sz.width * 0.25,
                  child: AppDropDownSimple(
                    onSelected: (value) {
                      if (value.isNull) return;

                      final note =
                          noteState.notes.firstWhere((n) => n.title.toUpperCase() == value).copyWith(isReference: true);

                      Dialogs.showDialogAction(
                        context: context,
                        title: 'Confirmar mudança de referência?',
                        description:
                            'Ao mudar o caderno de referência, todo o conteúdo e vínculos entre as questões serão removidos. Essa ação não pode ser desfeita.',
                        titleAction: 'Confirmar',
                        onPressed: () => context.read<NoteBloc>().updateNote(note),
                      );
                    },
                    onValidator: (value) {
                      return null;
                    },
                    value: noteState.reference!.title.toUpperCase(),
                    list: noteState.notes.map((n) => n.title.toUpperCase()).toList(),
                    labelText: '',
                    hint: 'Cadernos',
                    enable: true,
                  ),
                ),
              ],
            ),
            Flex(
              direction: mobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppInsets.med,
              children: [
                Text(
                  'Gerenciar usuários e permissões',
                  style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
                ),
                AppButton(
                  isLoading: false,
                  title: 'GERENCIAR',
                  backgroundColor: context.colorScheme.surface,
                  borderColor: context.colorScheme.onSecondaryFixedVariant,
                  overlayColor: context.colorScheme.secondary,
                  titleColor: context.colorScheme.onSecondaryFixedVariant,
                  onPressed: () {
                    Dialogs.showDialogAnimated(
                      context,
                      dialog: UsersDialog(
                        permissions: state.users,
                      ),
                    );
                  },
                ),
              ],
            ),
            Flex(
              direction: mobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppInsets.med,
              children: [
                Text(
                  'Exportar quadros de correção',
                  style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
                ),
                SizedBox(
                  width: context.sz.width * 0.25,
                  child: AppDropDownSimple(
                    onSelected: (value) {
                      if (value.isNull) return;

                      final display = value == 'Habilitado' ? true : false;

                      Dialogs.showDialogAction(
                        context: context,
                        title: 'Confirmar exibição de botões?',
                        description: 'Deseja exibir os botões de exportação nos quadros de correção?',
                        titleAction: 'Confirmar',
                        onPressed: () => _bloc.updateDisplay(
                          TBL0005(showButtons: display),
                        ),
                      );
                    },
                    onValidator: (value) {
                      return null;
                    },
                    value: state.display?.mapperBool,
                    list: ['Habilitado', 'Desabilitado'],
                    labelText: '',
                    hint: 'Selecione',
                    enable: true,
                  ),
                ),
              ],
            ),
            Flex(
              direction: mobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppInsets.med,
              children: [
                Text(
                  'Resetar todos os dados',
                  style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
                ),
                AppButton(
                  isLoading: false,
                  title: 'RESETAR',
                  backgroundColor: context.colorScheme.surface,
                  overlayColor: context.colorScheme.secondary,
                  borderColor: context.colorScheme.onSecondaryFixedVariant,
                  titleColor: context.colorScheme.onSecondaryFixedVariant,
                  onPressed: () {
                    Dialogs.showDialogAction(
                      context: context,
                      title: 'Resetar dados',
                      description: 'Deseja resetar os dados da aplicação?',
                      titleAction: 'CONFIRMAR',
                      onPressed: () => _bloc.reset(noteState.reference!),
                    );
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
