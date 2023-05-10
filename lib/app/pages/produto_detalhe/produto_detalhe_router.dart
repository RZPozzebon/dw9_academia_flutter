import 'package:dw9_delivery_app/app/pages/produto_detalhe/produto_datelhe_controller.dart';
import 'package:dw9_delivery_app/app/pages/produto_detalhe/produto_detalhe_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutoDetalheRouter {
  ProdutoDetalheRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProdutoDetalheController(),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProdutoDetalhePage(
            produto: args['produto'],
            order: args['order'],
          );
        },
      );
}
