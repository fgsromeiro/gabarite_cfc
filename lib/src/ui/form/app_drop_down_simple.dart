import '../../shared/export/app_export.dart';

class AppDropDownSimple extends StatefulWidget {
  const AppDropDownSimple({
    required this.onSelected,
    required this.onValidator,
    this.colorLabel = AppColors.white,
    required this.list,
    required this.labelText,
    required this.hint,
    required this.enable,
    this.showRequired = false,
    super.key,
    this.value,
    this.prefix,
  });

  final void Function(String? value) onSelected;
  final String? Function(String? value) onValidator;
  final List<String> list;
  final String labelText;
  final String hint;
  final String? value;
  final bool enable;
  final Color colorLabel;
  final bool showRequired;
  final Widget? prefix;

  @override
  State<AppDropDownSimple> createState() => _AppDropDownSimpleState();
}

class _AppDropDownSimpleState extends State<AppDropDownSimple> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: AppInsets.sm),
              child: Row(
                spacing: AppSpacing.xs,
                children: [
                  Expanded(
                    child: Visibility(
                      visible: widget.labelText.isNotEmpty,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.labelText,
                              style: context.theme.textTheme.labelMedium!.copyWith(color: widget.colorLabel),
                            ),
                            TextSpan(
                              text: widget.showRequired ? '*' : '',
                              style:
                                  context.theme.textTheme.labelMedium?.copyWith(color: context.theme.colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          DropdownButtonFormField<String>(
            focusNode: _focusNode,
            alignment: Alignment.centerLeft,
            initialValue: widget.value.isNotNull && widget.value!.isNotEmpty ? widget.value! : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            isExpanded: true,
            style: context.theme.textTheme.titleMedium!.copyWith(
              color: context.colorScheme.onTertiary,
            ),
            hint: Text(
              widget.hint,
              style: context.theme.inputDecorationTheme.hintStyle,
            ),
            validator: widget.onValidator,
            onChanged: (value) {
              if (value.isNotNull) {
                _focusNode.unfocus();
                widget.onSelected(value);
              }
            },
            autofocus: false,
            dropdownColor: context.colorScheme.surface,
            items: widget.enable
                ? widget.list.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      enabled: widget.enable,
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList()
                : null,
          ),
        ],
      ),
    );
  }
}
