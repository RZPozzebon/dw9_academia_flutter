import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appBar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/login/login_controller.dart';
import 'package:dw9_delivery_app/app/pages/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  // Variavel global
  final formKey = GlobalKey<FormState>();
  // Controller
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
            any: hideLoader,
            login: showLoader,
            loginError: () {
              hideLoader;
              showError('Login ou senha invalidos!');
            },
            error: () {
              hideLoader;
              showError('Erro ao realizar login');
            },
            sucesso: () {
              hideLoader;
              Navigator.pop(context, true);
            });
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style:
                            context.textStyles.textTitle.copyWith(fontSize: 28),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail é obrigatorio'),
                          Validatorless.email('E-mail não é valido')
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: senhaEC,
                        obscureText: true,
                        validator:
                            Validatorless.required('Senha é obrigadotira'),
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: DeliveryButton(
                          width: double.infinity,
                          label: 'ENTRAR',
                          onPressed: () {
                            final valido =
                                formKey.currentState?.validate() ?? false;
                            //Validação para enviar para controller
                            if (valido) {
                              controller.login(emailEC.text, senhaEC.text);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta',
                        style: context.textStyles.textbold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cadastro');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textbold.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
