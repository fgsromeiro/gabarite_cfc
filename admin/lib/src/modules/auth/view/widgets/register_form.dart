import '../../../../shared/export/app_export.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late GlobalKey<FormState> _formKey;
  late AuthBloc _bloc;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmedPasswordController;
  late FocusNode _focusNodePassword;
  late FocusNode _focusNodeConfirmedPassword;
  bool _visibility = true;
  bool _visibilityConfirmedPassword = true;
  bool _hasFocus = false;
  bool _hasFocusConfirmedPassword = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthBloc>();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmedPasswordController = TextEditingController();
    _focusNodePassword = FocusNode();
    _focusNodeConfirmedPassword = FocusNode();

    _focusNodePassword.addListener(
      () {
        if (_focusNodePassword.hasFocus) {
          setState(() => _hasFocus = true);
        } else {
          setState(() => _hasFocus = false);
        }
      },
    );

    _focusNodeConfirmedPassword.addListener(
      () {
        if (_focusNodeConfirmedPassword.hasFocus) {
          setState(() => _hasFocusConfirmedPassword = true);
        } else {
          setState(() => _hasFocusConfirmedPassword = false);
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authConfig = context.authConfig;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xs,
          children: [
            AuthHeaderTitle(
              title: 'Cadastre-se',
              subtitle: 'Preencha os campos abaixo para criar o seu acesso ao sistema.',
            ),
            10.h,
            Form(
              key: _formKey,
              child: Column(
                spacing: AppSpacing.sm,
                children: [
                  AppTextFormField(
                    labelText: 'Nome',
                    hintText: 'Informe o nome',
                    onChanged: context.read<AuthFormBloc>().setName,
                    onFieldSummited: (value) {
                      if (_formKey.currentState!.validate()) {
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
                    prefix: Icon(
                      Icons.person,
                      color: context.colorScheme.onSecondaryFixedVariant,
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Verifique o nome informado';
                      }
                      return null;
                    },
                    controller: _nameController,
                  ),
                  AppTextFormField(
                    labelText: 'E-mail',
                    hintText: 'Informe o e-mail',
                    onFieldSummited: (value) {
                      if (_formKey.currentState!.validate()) {
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
                    prefix: Icon(
                      Icons.email,
                      color: context.colorScheme.onSecondaryFixedVariant,
                    ),
                    validator: Utils.validateEmail,
                    controller: _emailController,
                    onChanged: context.read<AuthFormBloc>().setEmail,
                  ),
                  IntrinsicHeight(
                    child: Flex(
                      direction: authConfig.direction,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.sm,
                      children: [
                        Flexible(
                          child: AppTextFormField(
                            labelText: 'Senha',
                            hintText: 'Informe a senha',
                            prefix: Icon(
                              Icons.lock,
                              color: context.colorScheme.onSecondaryFixedVariant,
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Verifique a senha informada';
                              }
                              if (text.length < 6) {
                                return 'A senha deve ter no mínimo 6 caracteres';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            obscureText: _visibility,
                            focusNode: _focusNodePassword,
                            onFieldSummited: (value) {
                              if (_formKey.currentState!.validate()) {
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
                            onChanged: context.read<AuthFormBloc>().setPassword,
                          ),
                        ),
                        Flexible(
                          child: AppTextFormField(
                            labelText: 'Confirmar Senha',
                            hintText: 'Confirme a senha',
                            controller: _confirmedPasswordController,
                            prefix: Icon(
                              Icons.lock,
                              color: context.colorScheme.onSecondaryFixedVariant,
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Verifique a confirmação da senha';
                              }
                              if (text != _passwordController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
                            },
                            focusNode: _focusNodeConfirmedPassword,
                            obscureText: _visibilityConfirmedPassword,
                            onFieldSummited: (value) {
                              if (_formKey.currentState!.validate()) {
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
                            suffix: _hasFocusConfirmedPassword
                                ? IconButton(
                                    icon: Icon(
                                      _hasFocusConfirmedPassword ? Icons.visibility : Icons.visibility_off,
                                      color: context.colorScheme.onSecondaryFixedVariant,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _visibilityConfirmedPassword = !_visibilityConfirmedPassword;
                                      });
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.h,
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: 'CADASTRAR',
                      isLoading: state.status.isRegistering,
                      backgroundColor: context.colorScheme.secondary,
                      borderColor: context.colorScheme.secondary,
                      titleColor: context.colorScheme.primary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
