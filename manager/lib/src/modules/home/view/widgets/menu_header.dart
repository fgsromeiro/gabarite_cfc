// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../shared/export/app_export.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: context.sz.height * 0.1,
          width: double.infinity,
          child: Row(
            spacing: AppSpacing.med,
            children: [
              Container(
                width: context.sz.width * 0.0415,
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.profile,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        user.name.isEmpty ? 'Olá, Usuário!' : 'Olá, ${user.name}!',
                        style: context.theme.textTheme.titleMedium!.copyWith(color: context.colorScheme.onTertiary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      user.email.isEmpty ? '' : user.email,
                      style: context.theme.textTheme.titleMedium!.copyWith(color: context.colorScheme.onSecondary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
