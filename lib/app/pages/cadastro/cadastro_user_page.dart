import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appBar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_controller.dart';
import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class CadastroUserPage extends StatefulWidget {
  const CadastroUserPage({super.key});

  @override
  State<CadastroUserPage> createState() => _CadastroUserPageState();
}

class _CadastroUserPageState
    extends BaseState<CadastroUserPage, CadastroUserController> {
  //
  final _formKey = GlobalKey<FormState>();

  //
  final _nomeEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();

  @override
  void dispose() {
    _nomeEC.dispose();
    _emailEC.dispose();
    _senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CadastroUserController, CadastroUserState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            cadastrando: () => showLoader(),
            error: () {
              hideLoader();
              showError('Erro ao registrar login');
            },
            sucesso: () {
              hideLoader();
              showSuccess('Cadastro realizado com sucesso');
              Navigator.pop(context);
            });
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle.copyWith(fontSize: 28),
                  ),
                  Text(
                    'Preencha os campos para realizar o cadastro',
                    style: context.textStyles.textmedium.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nomeEC,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: Validatorless.required('Nome Obrigatorio'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail Obrigatorio'),
                        Validatorless.email('Email invalido')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _senhaEC,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatoria'),
                        Validatorless.min(
                            6, 'Senha deve conter pelo menos 6 caracteres')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'Confirmar Senha'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Confirmar senha é obrigatoria'),
                        Validatorless.compare(
                            _senhaEC, 'Senhas são diferentes.')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      onPressed: () {
                        final valido =
                            _formKey.currentState?.validate() ?? false;
                        if (valido) {
                          controller.register(
                            _nomeEC.text,
                            _emailEC.text,
                            _senhaEC.text,
                          );
                        }
                      },
                      label: 'Cadastrar',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
