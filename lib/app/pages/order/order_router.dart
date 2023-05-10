import 'package:dw9_delivery_app/app/pages/order/order_controller.dart';
import 'package:dw9_delivery_app/app/pages/order/order_page.dart';
import 'package:dw9_delivery_app/app/repositorio/order/order_repositorio.dart';
import 'package:dw9_delivery_app/app/repositorio/order/order_repositorio_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRouter {
  //Construtor privado
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepositorio>(
            create: (context) => OrderRepositorioImpl(dio: context.read()),
          ),
          Provider(
            create: ((context) => OrderController(context.read())),
          ),
        ],
        child: const OrderPage(),
      );
}
