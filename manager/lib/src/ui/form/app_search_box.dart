import '../../shared/export/app_export.dart';

class AppSearchBox extends StatefulWidget {
  const AppSearchBox({super.key, required this.onChanged});

  final void Function(String? value) onChanged;

  @override
  State<AppSearchBox> createState() => _AppSearchBoxState();
}

class _AppSearchBoxState extends State<AppSearchBox> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      onChanged: widget.onChanged,
      validator: (p0) {
        return null;
      },
    );
  }
}
