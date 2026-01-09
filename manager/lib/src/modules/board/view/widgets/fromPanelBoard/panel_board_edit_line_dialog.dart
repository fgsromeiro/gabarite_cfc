import '../../../../../shared/export/app_export.dart';

class PanelBoardEditLineDialog extends StatefulWidget {
  const PanelBoardEditLineDialog({
    super.key,
    required this.question,
  });

  final TBL0003 question;

  @override
  State<PanelBoardEditLineDialog> createState() => _PanelBoardEditLineDialogState();
}

class _PanelBoardEditLineDialogState extends State<PanelBoardEditLineDialog> {
  TBL0003? _questionCopied;
  String? _alternativeSelected;
  late final TextEditingController _enunciadedController;
  late final TextEditingController _textAlternativeController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _alternativeSelected = widget.question.alternative;
    _enunciadedController = TextEditingController(text: widget.question.enunciated);
    _textAlternativeController = TextEditingController(text: widget.question.textAlternative);
  }

  void reset() {
    _alternativeSelected = null;
    _enunciadedController.clear();
    _textAlternativeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final permission = context.read<MenuBloc>().state.user;

    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state.status == BoardStatus.updated) {
          Dialogs.showDialogMessage(
            context,
            message: 'Alterações salvas com sucesso.',
            color: context.colorScheme.onPrimary,
          );
          Navigator.pop(context);
          reset();
        } else if (state.status == BoardStatus.error) {
          Dialogs.showDialogMessage(
            context,
            message: state.message!,
            color: context.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(AppInsets.lg),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: context.colorScheme.primary,
                  ),
                ),
                width: context.sz.width * 0.6,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Responder Questão - N° ${widget.question.index}',
                        style: context.theme.textTheme.headlineMedium!.copyWith(
                          color: context.colorScheme.onTertiary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text('Selecione alternativa:',
                                textAlign: TextAlign.start,
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onTertiary,
                                )),
                          ),
                          Expanded(
                            flex: 4,
                            child: AppDropDownSimple(
                              onSelected: (value) {
                                _alternativeSelected = value;
                              },
                              value: widget.question.alternative,
                              onValidator: (_) {
                                if (_alternativeSelected.isNotNull && _alternativeSelected!.isNotEmpty) {
                                  return null;
                                }
                                return 'Por favor, selecione uma alternativa';
                              },
                              list: [
                                'A',
                                'B',
                                'C',
                                'D',
                                'A/R',
                                'B/R',
                                'C/R',
                                'D/R',
                                'ANULADO',
                                'RECURSO',
                              ],
                              labelText: '',
                              hint: 'Selecione',
                              enable: true,
                            ),
                          )
                        ],
                      ),
                      10.h,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('Enunciado:',
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onTertiary,
                                )),
                          ),
                          Expanded(
                            flex: 8,
                            child: AppTextFormField(
                              controller: _enunciadedController,
                              hintText: 'Exemplo: "A Sociedade Empresária adquiriu.."',
                              labelText: '',
                              validator: (value) {
                                if (value.isNotNull && value!.isNotEmpty) {
                                  return null;
                                }
                                return 'Por favor, informe o enunciado da questão';
                              },
                            ),
                          ),
                        ],
                      ),
                      10.h,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('Texto da alternativa:',
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onTertiary,
                                )),
                          ),
                          Expanded(
                            flex: 8,
                            child: AppTextFormField(
                              controller: _textAlternativeController,
                              hintText: 'Exemplo: "B"',
                              labelText: '',
                              validator: (value) {
                                if (value.isNotNull && value!.isNotEmpty) {
                                  return null;
                                }
                                return 'Por favor, informe o texto da alternativa escolhida';
                              },
                            ),
                          ),
                        ],
                      ),
                      15.h,
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 10,
                        children: [
                          AppButton(
                              isLoading: false,
                              title: 'CANCELAR',
                              onPressed: () {
                                Navigator.pop(context);
                                reset();
                              }),
                          AppButton(
                            title: 'SALVAR',
                            isLoading: state.status.isUpdating,
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              _questionCopied = widget.question.copyWith(
                                enunciated: _enunciadedController.text,
                                textAlternative: _textAlternativeController.text,
                                alternative: _alternativeSelected,
                                teacher: permission.name,
                              );

                              context.read<BoardBloc>().fillIn(_questionCopied!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
