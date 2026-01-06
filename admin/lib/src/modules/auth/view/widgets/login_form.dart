import '../../../../shared/export/app_export.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  late AuthBloc _bloc;
  late FocusNode _focusNode;
  bool _visibility = true;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthBloc>();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _focusNode = FocusNode();

    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          setState(() => _hasFocus = true);
        } else {
          setState(() => _hasFocus = false);
        }
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.lg,
          children: [
            AuthHeaderTitle(
              title: 'Olá, bem vindo(a) de volta!',
              subtitle: 'Faça o login para continuar.',
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.sm,
                children: [
                  AppTextFormField(
                    labelText: 'E-mail',
                    hintText: 'Informe o e-mail',
                    onFieldSummited: (value) {
                      if (_formKey.currentState!.validate()) {
                        final state = context.read<AuthFormBloc>().state;

                        context.read<AuthBloc>().login(
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
                    onChanged: context.read<AuthFormBloc>().setEmail,
                    prefix: Icon(
                      Icons.email,
                      color: context.colorScheme.onSecondaryFixedVariant,
                    ),
                    validator: Utils.validateEmail,
                    controller: _emailController,
                  ),
                  AppTextFormField(
                    labelText: 'Senha',
                    hintText: 'Informe a senha',
                    onFieldSummited: (value) {
                      if (_formKey.currentState!.validate()) {
                        final state = context.read<AuthFormBloc>().state;

                        context.read<AuthBloc>().login(
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
                    onChanged: context.read<AuthFormBloc>().setPassword,
                    prefix: Icon(
                      Icons.lock,
                      color: context.colorScheme.onSecondaryFixedVariant,
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Verifique a senha informada';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: _visibility,
                    focusNode: _focusNode,
                    suffix: _hasFocus
                        ? IconButton(
                            icon: Icon(
                              _hasFocus ? Icons.visibility : Icons.visibility_off,
                              color: context.colorScheme.onSecondaryFixedVariant,
                            ),
                            onPressed: () {
                              setState(() {
                                _visibility = !_visibility;
                              });
                            },
                          )
                        : null,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                title: 'ACESSAR',
                isLoading: state.status.isLogging,
                backgroundColor: context.colorScheme.secondary,
                borderColor: context.colorScheme.secondary,
                titleColor: context.colorScheme.primary,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
            )
          ],
        );
      },
    );
  }
}
