import 'package:dw9_delivery_app/app/pages/login/login_state.dart';
import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  //
  final AutenticacaoRepositorio _autenticacaoRepositorio;
// Contrutor
  LoginController(this._autenticacaoRepositorio)
      : super(const LoginState.initial());

  Future<void> login(String email, String senha) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final autenticacaoModel =
          await _autenticacaoRepositorio.login(email, senha);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', autenticacaoModel.accessToken);
      sp.setString('refreshToken', autenticacaoModel.refreshToken);

      emit(state.copyWith(status: LoginStatus.sucesso));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: 'Erro ao realizar login'));
    }
  }
}
