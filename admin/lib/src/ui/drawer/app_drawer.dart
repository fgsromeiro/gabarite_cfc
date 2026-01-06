import '../../shared/export/app_export.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.sz.width * 0.75,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
      ),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          final bloc = context.read<MenuBloc>();

          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: context.sz.height * 0.25,
                width: double.infinity,
                child: UserAccountsDrawerHeader(
                  accountName: Text(
                    state.user.name.isEmpty ? 'Olá, Usuário!' : 'Olá, ${state.user.name}!',
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onTertiary,
                      fontFamily: AppFonts.stemLight,
                    ),
                  ),
                  accountEmail: Text(
                    state.user.email.isEmpty ? '' : state.user.email,
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: context.colorScheme.onTertiary,
                      fontFamily: AppFonts.stemLight,
                    ),
                  ),
                  currentAccountPictureSize: Size(
                    context.sz.width * 0.15,
                    context.sz.width * 0.15,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: context.colorScheme.secondary,
                    backgroundImage: const AssetImage(ImageConstants.logo),
                  ),
                  decoration: BoxDecoration(color: context.colorScheme.surface),
                ),
              ),
              MenuListTile(
                isSelected: state.currentIndex == 0,
                onPressed: () {
                  bloc.selectMenu(0);
                  Navigator.pushReplacementNamed(context, AppRoutesSchema.boardSmScreen);
                },
                title: 'Realizar Correção',
                icon: Icons.assignment_turned_in,
                enable: true,
              ),
              MenuListTile(
                isSelected: state.currentIndex == 1,
                onPressed: () {
                  bloc.selectMenu(1);
                  Navigator.pushReplacementNamed(context, AppRoutesSchema.panelLinkSmScreen);
                },
                title: 'Vincular Cadernos',
                icon: Icons.link,
                enable: !state.permission.isTeacher,
              ),
              MenuListTile(
                isSelected: state.currentIndex == 2,
                onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutesSchema.competitorSmScreen),
                title: 'Analisar Concorrentes',
                icon: Icons.search,
                enable: !state.permission.isTeacher,
              ),
              MenuListTile(
                isSelected: state.currentIndex == 3,
                onPressed: () {
                  bloc.selectMenu(3);
                  Navigator.pushReplacementNamed(context, AppRoutesSchema.visibilitySmScreen);
                },
                title: 'Exibição',
                icon: Icons.visibility_outlined,
                enable: state.permission.isAdmin || state.permission.isTeacher || state.permission.isModerator,
              ),
              MenuListTile(
                isSelected: state.currentIndex == 4,
                onPressed: () {
                  bloc.selectMenu(4);
                  Navigator.pushReplacementNamed(context, AppRoutesSchema.settingPanelSmScreen);
                },
                title: 'Configuração',
                icon: Icons.settings,
                enable: state.permission.isAdmin,
              ), // AppListTileDrawer(
            ],
          );
        },
      ),
    );
  }
}
