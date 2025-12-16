import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  late AuthBloc _bloc;
  bool isFormLogin = true;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthBloc>();
    _bloc.load();
  }

  void toggleForm(bool to) {
    setState(() {
      isFormLogin = to;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authConfig = context.authConfig;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status.isLogged) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutesSchema.homeScreen,
          );
        }
        if (state.status == AuthStatus.error) {
          Dialogs.showDialogMessage(
            context,
            message: state.message!,
            color: context.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        return Flex(
          direction: authConfig.direction,
          children: [
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(AppInsets.lg),
                child: Column(
                  children: [
                    Row(
                      children: [Image.asset(ImageConstants.logoCorrecao, scale: AppBannerSize.logoXl + 5)],
                    ),
                    Expanded(
                      child: Container(
                        height: context.sz.height * 0.7,
                        width: context.width * authConfig.percential,
                        alignment: Alignment.center,
                        constraints: BoxConstraints(maxHeight: context.sz.height * 0.7),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeRight: true,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: AppSpacing.med,
                                children: [
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 300),
                                    firstChild: LoginForm(key: AppKeysForms.formLoginKey),
                                    secondChild: RegisterForm(key: AppKeysForms.formRegisterKey),
                                    crossFadeState: isFormLogin ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: AppConditionalWidget(
                                      condition: isFormLogin,
                                      firstChild: AppButton(
                                        title: 'ACESSAR',
                                        isLoading: state.status.isLogging,
                                        backgroundColor:
                                            isFormLogin ? context.colorScheme.secondary : context.colorScheme.surface,
                                        borderColor: isFormLogin
                                            ? context.colorScheme.secondary
                                            : context.colorScheme.onTertiary,
                                        titleColor:
                                            isFormLogin ? context.colorScheme.primary : context.colorScheme.onTertiary,
                                        onPressed: () {
                                          if (!isFormLogin) return toggleForm(true);

                                          if (AppKeysForms.formLoginKey.currentState!.validate()) {
                                            final state = context.read<AuthFormBloc>().state;

                                            _bloc.login(
                                              AuthManagerDTO(
                                                email: state.email,
                                                password: state.password,
                                              ),
                                            );
                                          } else {
                                            Dialogs.showDialogMessage(
                                              context,
                                              message: 'Verifique suas credeciais',
                                              color: context.colorScheme.error,
                                            );
                                          }
                                        },
                                      ),
                                      secondChild: AppButton(
                                        title: 'CADASTRAR',
                                        isLoading: state.status.isRegistering,
                                        backgroundColor:
                                            !isFormLogin ? context.colorScheme.secondary : context.colorScheme.surface,
                                        borderColor: !isFormLogin
                                            ? context.colorScheme.secondary
                                            : context.colorScheme.onTertiary,
                                        titleColor:
                                            !isFormLogin ? context.colorScheme.primary : context.colorScheme.onTertiary,
                                        onPressed: () {
                                          if (isFormLogin) return toggleForm(false);

                                          if (AppKeysForms.formRegisterKey.currentState!.validate()) {
                                            final state = context.read<AuthFormBloc>().state;

                                            _bloc.signUp(
                                              AuthManagerDTO(
                                                email: state.email,
                                                password: state.password,
                                                name: state.name,
                                              ),
                                            );
                                          } else {
                                            Dialogs.showDialogMessage(
                                              context,
                                              message: 'Verifique suas credeciais',
                                              color: context.colorScheme.error,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: AppConditionalWidget(
                                      condition: isFormLogin,
                                      firstChild: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: AppSpacing.xs,
                                        children: [
                                          Text(
                                            'Ainda não possui uma conta?',
                                            textAlign: TextAlign.center,
                                            style: context.theme.textTheme.bodyMedium!.copyWith(
                                              color: context.colorScheme.onSecondary,
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(50, 30),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            onPressed: () {
                                              toggleForm(!isFormLogin);
                                            },
                                            child: Text(
                                              'Cadastre-se.',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: AppSpacing.xs,
                                        children: [
                                          Text(
                                            'Já possui uma conta?',
                                            textAlign: TextAlign.center,
                                            style: context.theme.textTheme.bodyMedium!.copyWith(
                                              color: context.colorScheme.onSecondary,
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(50, 30),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            onPressed: () {
                                              toggleForm(!isFormLogin);
                                            },
                                            child: Text(
                                              'Acesse sua conta.',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: authConfig.isVisibilityBanner,
              child: Flexible(
                flex: 6,
                child: Container(
                  color: context.colorScheme.onTertiary,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageConstants.bannerLogin,
                    scale: AppBannerSize.logoLg,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
