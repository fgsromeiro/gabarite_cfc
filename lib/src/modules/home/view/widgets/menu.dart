// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:correcao_cfc/src/modules/home/view/bloc/menu_bloc.dart';
import 'package:correcao_cfc/src/modules/home/view/bloc/menu_state.dart';
import 'package:correcao_cfc/src/modules/home/view/widgets/menu_header.dart';
import 'package:correcao_cfc/src/modules/home/view/widgets/menu_itens.dart';
import 'package:correcao_cfc/src/modules/home/view/widgets/menu_loading.dart';
import 'package:correcao_cfc/src/shared/extension/extension_context.dart';
import 'package:correcao_cfc/src/theme/app_insets.dart';
import 'package:correcao_cfc/src/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/app_colors.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return MenuLoading();
        }

        return Container(
          padding: EdgeInsets.all(AppInsets.lg),
          decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: context.colorScheme.onSecondaryFixedVariant,
                width: 1,
              )),
          child: Column(
            children: [
              MenuHeader(user: state.user),
              Divider(),
              Expanded(
                flex: 8,
                child: MenuItens(),
              )
            ],
          ),
        );
      },
    );
  }
}
