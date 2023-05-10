import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/pages/home/home_page.dart';
import 'package:dw9_delivery_app/app/repositorio/produto_repositorio.dart';
import 'package:dw9_delivery_app/app/repositorio/produto_repositorio_implements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest_client/custom_dio.dart';

class HomeRouter {
  //Construtor privado
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProdutoRepositorio>(
            create: (context) => ProdutoRepositorioImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider(create: (context) => HomeController(context.read()))
        ],
        child: const HomePage(),
      );
}
