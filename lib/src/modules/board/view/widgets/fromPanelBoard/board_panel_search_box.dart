import '../../../../../shared/export/app_export.dart';

class BoardSearchBox extends StatefulWidget {
  const BoardSearchBox({super.key});

  @override
  State<BoardSearchBox> createState() => _BoardSearchBoxState();
}

class _BoardSearchBoxState extends State<BoardSearchBox> {
  late final TextEditingController controller;
  late final BoardBloc bloc;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    bloc = context.read<BoardBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      textInputFormatter: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s]+$')),
      ],
      labelText: '',
      hintText: 'Informe o número da questão',
      prefix: Icon(
        Icons.search,
        color: context.colorScheme.onPrimaryFixedVariant,
      ),
      controller: controller,
      onChanged: bloc.search,
      validator: (p0) {
        return null;
      },
    );
  }
}
