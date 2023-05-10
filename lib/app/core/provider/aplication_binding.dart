import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio.dart';
import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../rest_client/custom_dio.dart';

class AplicationBinding extends StatelessWidget {
  //
  final Widget child;
  // Construtor
  const AplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider<AutenticacaoRepositorio>(
          create: (context) => AutenticacaoRepositorioImpl(dio: context.read()),
        ),
      ],
      child: child,
    );
  }
}
