import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/widget/synchronized_button.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppSectionTitle(title: 'メールアドレスでログイン'),
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextFormField(
                      controller: emailController,
                      hintText: 'メールアドレスを入力してください',
                      labelText: 'メールアドレス',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      controller: passwordController,
                      hintText: 'パスワードを入力してください',
                      labelText: 'パスワード',
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    SynchronizedButton.elevated(
                      onPressed: () async {
                        final result = await ref
                            .read(accountStateProvider.notifier)
                            .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) {
                            showAppSnackBar(context, 'ログインに成功しました');
                            context.router.pop();
                          },
                        );
                      },
                      child: const Text('ログイン'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
                child: Divider(),
              ),
              const AppSectionTitle(title: 'その他のアカウントでログイン'),
              const SizedBox(height: 16),
              SignInButton(
                Buttons.Google,
                padding: const EdgeInsets.all(4),
                text: 'Google でログイン',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SignInButton(
                Buttons.Apple,
                padding: const EdgeInsets.all(12),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
