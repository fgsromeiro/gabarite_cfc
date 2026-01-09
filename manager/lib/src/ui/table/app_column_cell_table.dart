import '../../shared/export/app_export.dart';

class AppColumnCellTable {
  static DataColumn create(
    BuildContext context, {
    required String title,
    TableColumnWidth? columnWidth,
  }) {
    return DataColumn(
      headingRowAlignment: MainAxisAlignment.center,
      columnWidth: columnWidth,
      
      label: Text(
        title,
        style: context.theme.textTheme.headlineSmall!.copyWith(
          color: context.colorScheme.onTertiary,
          // fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
