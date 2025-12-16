import '../../../../../shared/export/app_export.dart';

class PanelBoardSmFormBody extends StatefulWidget {
  const PanelBoardSmFormBody({super.key, required this.question});

  final TBL0003 question;

  @override
  State<PanelBoardSmFormBody> createState() => _PanelBoardSmFormBodyState();
}

class _PanelBoardSmFormBodyState extends State<PanelBoardSmFormBody> {
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
  void dispose() {
    reset();
    super.dispose();
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
      builder: (context, state) => Padding(
        padding: EdgeInsetsGeometry.only(
          left: AppSpacing.med,
          right: AppSpacing.med,
          bottom: AppSpacing.med,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Responder Questão - N° 01', style: context.theme.textTheme.headlineMedium),
                      AppDivider(showPoint: false),
                      10.h,
                      AppDropDownSimple(
                        onSelected: (value) => _alternativeSelected = value,
                        value: widget.question.alternative,
                        onValidator: (_) {
                          if (_alternativeSelected.isNotNull && _alternativeSelected!.isNotEmpty) {
                            return null;
                          }
                          return 'Por favor, selecione uma alternativa';
                        },
                        list: ['A', 'B', 'C', 'D', 'A/R', 'B/R', 'C/R', 'D/R', 'ANULADO', 'RECURSO'],
                        labelText: 'Selecione alternativa',
                        showRequired: true,
                        hint: 'Selecione',
                        enable: true,
                      ),
                      20.h,
                      AppTextFormField(
                        controller: _enunciadedController,
                        hintText: 'Exemplo: "A Sociedade Empresária adquiriu.."',
                        labelText: 'Enunciado',
                        showRequired: true,
                        validator: (value) {
                          if (value.isNotNull && value!.isNotEmpty) {
                            return null;
                          }
                          return 'Por favor, informe o enunciado da questão';
                        },
                      ),
                      20.h,
                      AppTextFormField(
                        controller: _textAlternativeController,
                        hintText: 'Exemplo: "B"',
                        labelText: 'Texto da Alternativa',
                        showRequired: true,
                        validator: (value) {
                          if (value.isNotNull && value!.isNotEmpty) {
                            return null;
                          }
                          return 'Por favor, informe o texto da alternativa escolhida';
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Expanded(
                    child: AppButton(
                        isLoading: false,
                        title: 'CANCELAR',
                        backgroundColor: context.colorScheme.surface,
                        borderColor: context.colorScheme.secondary,
                        titleColor: context.colorScheme.secondary,
                        onPressed: () {
                          Navigator.pop(context);
                          // reset();
                        }),
                  ),
                  Expanded(
                    child: AppButton(
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
