import 'package:dw9_delivery_app/app/pages/login/login_controller.dart';
import 'package:dw9_delivery_app/app/pages/login/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  //
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => LoginController(context.read()))
        ],
        child: const LoginPage(),
      );
}
