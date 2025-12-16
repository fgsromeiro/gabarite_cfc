import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class AppTextFieldSimple extends StatefulWidget {
  AppTextFieldSimple({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.textInputType,
  });

  final String labelText;
  TextInputType? textInputType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final String hintText;

  @override
  State<AppTextFieldSimple> createState() => _AppTextFieldSimpleState();
}

class _AppTextFieldSimpleState extends State<AppTextFieldSimple> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.labelText,
          style: context.theme.textTheme.bodyMedium,
        ),
        TextFormField(
          focusNode: _focusNode,
          scrollPadding: const EdgeInsets.only(bottom: 500),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.textInputType,
          cursorColor: context.colorScheme.onPrimary,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: widget.controller,
          validator: widget.validator,
          style: const TextStyle(fontSize: 18),
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: _isFocused ? widget.hintText : null,
            hintStyle: TextStyle(
              color: context.colorScheme.scrim,
              fontWeight: FontWeight.w100,
              fontSize: 18,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
            ),
            focusedBorder: _customBorder(
              colorBorder: context.colorScheme.onPrimary,
              widthBorder: 2,
            ),
            errorBorder: _customBorder(colorBorder: context.colorScheme.error),
          ),
          // inputFormatters: textInputFormatter,
        ),
      ],
    );
  }

  InputBorder _customBorder({Color? colorBorder, double? widthBorder}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: colorBorder ?? context.colorScheme.scrim,
        width: widthBorder ?? 1,
      ),
    );
  }
}
