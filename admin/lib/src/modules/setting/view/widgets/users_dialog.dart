import '../../../../shared/export/app_export.dart';

class UsersDialog extends StatelessWidget {
  const UsersDialog({
    super.key,
    required this.permissions,
  });

  final List<TBL0004> permissions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: context.colorScheme.primary),
      ),
      title: Text(
        "Usuários do sistema",
        style: context.theme.textTheme.headlineMedium!.copyWith(
          color: context.colorScheme.onTertiary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        height: context.sz.height * 0.5,
        width: context.sz.width * 0.4,
        child: BlocConsumer<SettingBloc, SettingState>(
          listener: (context, state) {
            if (state.status.isError) {
              Dialogs.showDialogMessage(
                context,
                message: state.message ?? 'Erro ao atualizar permissão',
                color: context.colorScheme.error,
              );
            } else if (state.status.isUpdated) {
              Navigator.of(context).pop();
              Dialogs.showDialogMessage(
                context,
                message: 'Permissão atualizada com sucesso!',
                color: context.colorScheme.primary,
              );
            }
          },
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];

                return _lineDialog(context, permission: user);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _lineDialog(
    BuildContext context, {
    required TBL0004 permission,
  }) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) => MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Container(
          padding: EdgeInsets.all(AppInsets.lg),
          margin: EdgeInsets.symmetric(vertical: AppInsets.sm),
          decoration: BoxDecoration(
            color: isHovered ? context.colorScheme.scrim.withAlpha(55) : null,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text(
                  permission.name,
                  style: context.theme.textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.onTertiary,
                  ),
                ),
              ),
              Flexible(
                child: AppDropDownSimple(
                  onSelected: (value) {
                    if (value.isNull) return;
                    context.read<SettingBloc>().updatePermission(permission.copyWith(type: value!.toLowerCase()));
                  },
                  onValidator: (value) {
                    return null;
                  },
                  list: [
                    'Admin',
                    'Moderador',
                    'Professor',
                    'Produtos',
                  ],
                  labelText: '',
                  hint: 'Selecione',
                  enable: true,
                  value: permission.type.characters.first.toUpperCase() + permission.type.substring(1).toLowerCase(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
