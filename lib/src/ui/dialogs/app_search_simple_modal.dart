import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AppSearcSimpleModal extends StatefulWidget {
  const AppSearcSimpleModal({
    super.key,
    this.value,
  });

  final String? value;

  @override
  State<AppSearcSimpleModal> createState() => _CalculatorSearchNCMModalState();
}

class _CalculatorSearchNCMModalState extends State<AppSearcSimpleModal> {
  late final TextEditingController _controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppInsets.med, horizontal: AppInsets.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pesquisar',
                      style: context.theme.textTheme.headlineMedium!.copyWith(color: context.colorScheme.onTertiary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              AppTextFormField(
                labelText: '',
                hintText: 'Informe o número da questão',
                controller: _controller,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value != null || value!.isNotEmpty) {
                    return null;
                  }
                  return 'Informe o número da questão';
                },
              ),
              10.h,
              Flex(
                direction: Axis.horizontal,
                spacing: 10,
                children: [
                  Expanded(
                    child: AppButton(
                      isLoading: false,
                      title: 'LIMPAR',
                      backgroundColor: context.colorScheme.surface,
                      borderColor: context.colorScheme.secondary,
                      titleColor: context.colorScheme.secondary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      isLoading: false,
                      title: 'PESQUISAR',
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.pop(context, _controller.text);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
