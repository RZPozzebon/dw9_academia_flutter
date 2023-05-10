import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_controller.dart';
import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_page.dart';
import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CadastroRouter {
  //
  CadastroRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) =>
                CadastroUserController(context.read<AutenticacaoRepositorio>()),
          ),
        ],
        child: const CadastroUserPage(),
      );
}
