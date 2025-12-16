import 'package:gabarite_cfc/src/ui/dialogs/app_list_questions_reference_modal.dart';
import 'package:gabarite_cfc/src/ui/dialogs/app_search_simple_modal.dart';

import '../../shared/export/app_export.dart';

class Dialogs {
  static Future<T?> showDialogAnimated<T>(
    BuildContext context, {
    required Widget dialog,
    bool barrierDismissible = true,
  }) async {
    final result = await showGeneralDialog<T>(
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      context: context,
      barrierColor: context.theme.colorScheme.onPrimaryFixed,
      transitionDuration: Duration(milliseconds: 600),
      transitionBuilder: (_, a1, a2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: a1,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInOutExpo,
          ),
          child: dialog,
        );
      },
      pageBuilder: (BuildContext context, anim, child) => SizedBox.shrink(),
    );

    return result;
  }

  static void showDialogMessage(
    BuildContext context, {
    required String message,
    required Color color,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => AppTopDialog(
        message: message,
        duration: Duration(seconds: 3),
        onDismiss: () => entry.remove(),
        backgroundColor: color,
      ),
    );

    overlay.insert(entry);
  }

  static Future<bool> showDialogAction({
    required BuildContext context,
    required String title,
    required String description,
    required String titleAction,
    required VoidCallback onPressed,
  }) async {
    bool? isAction;

    isAction = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          backgroundColor: AppColors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(AppRadius.lg),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: context.colorScheme.primary,
                  ),
                ),
                width: context.isMobile ? context.sz.width * 0.9 : context.sz.width * 0.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.med,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.headlineMedium!.copyWith(
                        color: context.colorScheme.onTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.start,
                      style: context.theme.textTheme.headlineSmall!.copyWith(
                        color: context.colorScheme.onSecondaryFixedVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: AppSpacing.sm,
                      children: [
                        AppButton(
                          isLoading: false,
                          title: 'Cancelar',
                          backgroundColor: context.colorScheme.surface,
                          titleColor: context.colorScheme.onTertiary,
                          overlayColor: context.colorScheme.primary,
                          borderColor: context.colorScheme.onSecondaryFixedVariant,
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        AppButton(
                          isLoading: false,
                          title: titleAction,
                          backgroundColor: context.colorScheme.primary,
                          overlayColor: context.colorScheme.secondary,
                          titleColor: context.colorScheme.onTertiary,
                          borderColor: context.colorScheme.onSecondaryFixedVariant,
                          onPressed: () {
                            onPressed();
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    return isAction ?? false;
  }

  static Future<TBL0003?> showDialogSelectQuestionToLink(
    BuildContext context,
    List<String> listIdsQuestionsLinked,
  ) async {
    return await showModalBottomSheet<TBL0003?>(
      context: context,
      builder: (context) => AppListQuestionsReferenceModal(value: listIdsQuestionsLinked),
    );
  }

  static Future<String?> showDialogSearch(
    BuildContext context,
    String? initialValue,
  ) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (context) => AppSearcSimpleModal(value: initialValue),
    );
  }

  static Future<FilterQuestion?> showDialogFilter(
    BuildContext context,
    FilterQuestion initialValue,
  ) async {
    return await showModalBottomSheet<FilterQuestion?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.surface.withBlue(30),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Todas',
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                    color: context.colorScheme.onTertiary,
                  ),
                ),
                trailing:
                    initialValue == FilterQuestion.all ? Icon(Icons.check, color: context.colorScheme.onPrimary) : null,
                onTap: () => Navigator.pop(context, FilterQuestion.all),
              ),
              ListTile(
                title: Text(
                  'Respondidas',
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                    color: context.colorScheme.onTertiary,
                  ),
                ),
                trailing: initialValue == FilterQuestion.answered
                    ? Icon(Icons.check, color: context.colorScheme.onPrimary)
                    : null,
                onTap: () => Navigator.pop(context, FilterQuestion.answered),
              ),
              ListTile(
                title: Text(
                  'Pendentes',
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                    color: context.colorScheme.onTertiary,
                  ),
                ),
                trailing: initialValue == FilterQuestion.notAnswered
                    ? Icon(Icons.check, color: context.colorScheme.onPrimary)
                    : null,
                onTap: () => Navigator.pop(context, FilterQuestion.notAnswered),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<TBL0001?> showDialogNotes(BuildContext context, TBL0001? initialValue) async {
    final stateNote = context.read<NoteBloc>().state;
    final notes = stateNote.notes.where((n) => !n.isReference).toList();

    return await showModalBottomSheet<TBL0001?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorScheme.surface.withBlue(30),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...notes.map((note) => ListTile(
                    title: Text(
                      note.title.toUpperCase(),
                      style: context.theme.textTheme.headlineSmall!.copyWith(
                        color: context.colorScheme.onTertiary,
                      ),
                    ),
                    trailing:
                        initialValue?.id == note.id ? Icon(Icons.check, color: context.colorScheme.onPrimary) : null,
                    onTap: () => Navigator.pop(context, note),
                  )),
            ],
          ),
        );
      },
    );
  }
}
