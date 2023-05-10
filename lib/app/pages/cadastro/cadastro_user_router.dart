import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_controller.dart';
import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroUserRouter {
  // Construtor privado
  CadastroUserRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => CadastroUserController(
              context.read(),
            ),
          ),
        ],
        child: const CadastroUserPage(), // Page
      );
}
