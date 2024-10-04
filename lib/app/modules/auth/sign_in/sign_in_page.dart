import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/constants/routes.dart';
import '../auth_states.dart';
import '../components/password_field.dart';
import '../components/text_header.dart';
import '../components/username_field.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Expanded(flex: 2, child: SizedBox.shrink()),
              const Expanded(child: TextHeader('Welcome!')),
              Expanded(
                flex: 6,
                child: Center(
                  child: SingleChildScrollView(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final authState = ref.watch(SignInController.provider);

                        ref.listen(
                            SignInController.provider,
                            (_, next) => switch (next) {
                                  ErrorAuthState() =>
                                    _showErrorOnSnackbar(context, next),
                                  SuccessAuthState() => Navigator.of(context)
                                      .pushReplacementNamed(Routes.home),
                                  _ => null,
                                });

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UsernameField(controller: username),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: password,
                              onSubmitted: () => _signIn(ref),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Routes.recoveryPassword),
                                child: const Text('Forgot password?'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: switch (authState) {
                                LoadingAuthState() => Center(
                                    child: Transform.scale(
                                      scale: 0.6,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ),
                                _ => FilledButton(
                                    onPressed: () => _signIn(ref),
                                    child: const Center(
                                      child: Text('SIGN IN'),
                                    ),
                                  ),
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Are you new here? '),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushReplacementNamed(Routes.signUp),
                                    child: const Text('Create account'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(WidgetRef ref) {
    if (_validateAll()) {
      ref.read(SignInController.provider.notifier).signIn(
            username: username.text,
            password: password.text,
          );
    }
  }

  bool _validateAll() => formKey.currentState?.validate() ?? false;

  void _showErrorOnSnackbar(BuildContext context, ErrorAuthState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.error.message)),
    );
  }
}
