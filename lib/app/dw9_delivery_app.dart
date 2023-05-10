import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_router.dart';
import 'package:dw9_delivery_app/app/pages/home/home_router.dart';
import 'package:dw9_delivery_app/app/pages/login/login_router.dart';
import 'package:dw9_delivery_app/app/pages/order/order_router.dart';
import 'package:dw9_delivery_app/app/pages/produto_detalhe/produto_detalhe_router.dart';
import 'package:flutter/material.dart';
import 'core/provider/aplication_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/splash/splash_page.dart';

class Dw9DeliveryApp extends StatelessWidget {
  const Dw9DeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AplicationBinding(
      child: MaterialApp(
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/produtoDetalhe': (context) => ProdutoDetalheRouter.page,
          '/login': (context) => LoginRouter.page,
          '/cadastro': (context) => CadastroRouter.page,
          '/order': (context) => OrderRouter.page,
        },
      ),
    );
  }
}
