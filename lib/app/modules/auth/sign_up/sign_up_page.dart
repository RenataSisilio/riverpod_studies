import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/routes.dart';
import '../auth_states.dart';
import '../components/email_field.dart';
import '../components/password_field.dart';
import '../components/text_header.dart';
import '../components/username_field.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
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
                child: SingleChildScrollView(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(SignUpController.provider);

                      ref.listen(
                        SignUpController.provider,
                        (_, next) => switch (next) {
                          ErrorAuthState() =>
                            _showErrorOnSnackbar(context, next),
                          SuccessAuthState() => Navigator.of(context)
                              .pushReplacementNamed(Routes.home),
                          _ => null,
                        },
                      );

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UsernameField(controller: username),
                          const SizedBox(height: 16),
                          EmailField(controller: email),
                          const SizedBox(height: 16),
                          PasswordField(controller: password),
                          const SizedBox(height: 16),
                          PasswordField.confirm(
                            onSubmitted: () => _signUp(ref),
                            originalValueToMatch: password,
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
                                  onPressed: () => _signUp(ref),
                                  child: const Center(
                                    child: Text('CREATE ACCOUNT'),
                                  ),
                                ),
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already registered? '),
                                TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed(Routes.signIn),
                                  child: const Text('Sign in'),
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
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(WidgetRef ref) {
    if (_validateAll()) {
      ref.read(SignUpController.provider.notifier).signUp(
            username: username.text,
            email: email.text,
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
