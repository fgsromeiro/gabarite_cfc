import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class AppRowCellTable {
  static DataCell create(
    BuildContext context, {
    required String title,
    double? maxWidth,
    Widget? trailing,
  }) {
    return DataCell(
      Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: maxWidth ?? 700),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (trailing != null) trailing,
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(),
              constraints: BoxConstraints(maxWidth: maxWidth ?? 700),
              child: Text(
                title.isEmpty ? 'N/A' : title,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  color: title.isEmpty ? context.colorScheme.onSecondaryFixedVariant : context.colorScheme.onTertiary,
                  // fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static DataCell action(
    BuildContext context, {
    required Widget child,
  }) {
    return DataCell(
      Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 700),
        child: child,
      ),
    );
  }

  static DataCell field(
    BuildContext context, {
    required String title,
    required double fator,
    void Function(String value)? onChanged,
  }) {
    final controller = TextEditingController(text: title);

    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onChanged?.call(controller.text);
      }
    });

    return DataCell(
      Center(
        child: SizedBox(
            width: context.sz.width * fator,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onChanged,
              onTapOutside: (event) => onChanged?.call(controller.text),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9/]')),
                TextInputFormatter.withFunction(
                  (oldValue, newValue) => newValue.copyWith(
                    text: newValue.text.toUpperCase(),
                  ),
                ),
              ],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              style: context.theme.textTheme.titleMedium!
                  .copyWith(color: context.colorScheme.onTertiary, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
