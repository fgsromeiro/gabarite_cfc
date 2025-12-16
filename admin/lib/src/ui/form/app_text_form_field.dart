import '../../shared/export/app_export.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.textInputType = TextInputType.emailAddress,
    this.textInputFormatter,
    this.onFieldSummited,
    this.colorBorder,
    this.colorLabel = AppColors.white,
    this.fillColor = AppColors.formFieldBackground,
    this.showRequired = false,
    this.onSave,
    this.onChanged,
    this.suffix,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.focusNode,
    this.prefix,
    bool? enable,
    super.key,
  }) : enable = enable ?? true;

  final String labelText;
  final Widget? suffix;
  final Widget? prefix;
  final Color colorLabel;
  final Color fillColor;
  final Color? colorBorder;
  final bool showRequired;
  final String hintText;
  final String? Function(String? value) validator;
  final void Function(String? value)? onSave;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onFieldSummited;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextCapitalization textCapitalization;

  final bool obscureText;
  final FocusNode? focusNode;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: AppInsets.sm),
          child: Row(
            spacing: AppSpacing.xs,
            children: [
              Expanded(
                child: Visibility(
                  visible: labelText.isNotEmpty,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: labelText,
                          style: context.theme.textTheme.labelMedium!.copyWith(color: context.colorScheme.onTertiary),
                        ),
                        TextSpan(
                          text: showRequired ? '*' : '',
                          style: context.theme.textTheme.labelMedium?.copyWith(color: context.theme.colorScheme.error),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          enabled: enable,
          focusNode: focusNode,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          keyboardType: textInputType,
          scrollPadding: const EdgeInsets.only(bottom: 200),
          cursorColor: AppColors.secondary,
          onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(AppInsets.sm),
            suffixIcon: suffix,
            prefixIcon: prefix != null
                ? Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: prefix,
                  )
                : null,
            hintText: hintText,
            prefixIconConstraints: prefix != null ? BoxConstraints(maxWidth: context.sz.width * 0.12) : null,
          ),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            color: enable! ? context.colorScheme.onTertiary : context.colorScheme.onSecondaryFixedVariant,
          ),
          onSaved: onSave,
          onFieldSubmitted: onFieldSummited,
          inputFormatters: textInputFormatter,
        ),
      ],
    );
  }
}
