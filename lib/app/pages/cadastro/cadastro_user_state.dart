// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

// Parte do código nesse arquivo
part 'cadastro_user_state.g.dart';

@match
enum CadastroStatus {
  initial,
  cadastrando,
  sucesso,
  error,
}

class CadastroUserState extends Equatable {
  //Atributos
  final CadastroStatus status;

  //Construtor
  const CadastroUserState({
    required this.status,
  });

  const CadastroUserState.initial() : status = CadastroStatus.initial;

  CadastroUserState copyWith({
    CadastroStatus? status,
  }) {
    return CadastroUserState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
