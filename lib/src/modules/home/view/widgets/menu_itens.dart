import '../../../../shared/export/app_export.dart';

class MenuItens extends StatelessWidget {
  const MenuItens({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MenuBloc>();
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                MenuListTile(
                  isSelected: state.currentIndex == 0,
                  onPressed: () => bloc.selectMenu(0),
                  title: 'Realizar Correção',
                  icon: Icons.assignment_turned_in,
                  enable: true,
                ),
                MenuListTile(
                  isSelected: state.currentIndex == 1,
                  onPressed: () => bloc.selectMenu(1),
                  title: 'Vincular Cadernos',
                  icon: Icons.link,
                  enable: state.permission.isProducts || state.permission.isAdmin,
                ),
                MenuListTile(
                  isSelected: state.currentIndex == 2,
                  onPressed: () => Navigator.pushNamed(context, AppRoutesSchema.competitorScreen),
                  title: 'Analisar Concorrentes',
                  icon: Icons.search,
                  enable: state.permission.isProducts || state.permission.isAdmin,
                ),
                MenuListTile(
                  isSelected: state.currentIndex == 3,
                  onPressed: () => bloc.selectMenu(3),
                  title: 'Exibição',
                  icon: Icons.visibility_outlined,
                  enable: state.permission.isAdmin || !state.permission.isProducts,
                ),
                MenuListTile(
                  isSelected: state.currentIndex == 4,
                  onPressed: () => bloc.selectMenu(4),
                  title: 'Configuração',
                  icon: Icons.settings,
                  enable: state.permission.isAdmin,
                ),
              ],
            ),
            MenuListTile(
              isSelected: state.currentIndex == 5,
              onPressed: () => Dialogs.showDialogAction(
                context: context,
                title: 'Deseja sair?',
                description: 'Tem certeza que deseja sair?',
                titleAction: 'Sair',
                onPressed: () {
                  context.read<AuthBloc>().logout();
                },
              ),
              enable: true,
              title: 'Sair',
              icon: Icons.logout,
            ),
          ],
        );
      },
    );
  }
}
