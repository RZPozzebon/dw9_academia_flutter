import 'package:dw9_delivery_app/app/pages/cadastro/cadastro_user_state.dart';
import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastroUserController extends Cubit<CadastroUserState> {
  //
  final AutenticacaoRepositorio _autenticacaoRepositorio;

  CadastroUserController(this._autenticacaoRepositorio)
      : super(const CadastroUserState.initial());

  Future<void> register(String nome, String email, String senha) async {
    try {
      emit(state.copyWith(status: CadastroStatus.cadastrando));
      await _autenticacaoRepositorio.register(nome, email, senha);
      emit(state.copyWith(status: CadastroStatus.sucesso));
    } catch (e) {
      //log('Erro ao registar usuário')
      emit(state.copyWith(status: CadastroStatus.error));
    }
  }
}
