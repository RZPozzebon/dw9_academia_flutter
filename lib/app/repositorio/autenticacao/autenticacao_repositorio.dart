import 'package:dw9_delivery_app/app/models/autenticacao_model.dart';

abstract class AutenticacaoRepositorio {
  //
  Future<void> register(String nome, String email, String senha);

  Future<AutenticacaoModel> login(String email, String senha);
}
