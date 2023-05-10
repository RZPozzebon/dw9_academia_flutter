// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_user_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CadastroStatusMatch on CadastroStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() cadastrando,
      required T Function() sucesso,
      required T Function() error}) {
    final v = this;
    if (v == CadastroStatus.initial) {
      return initial();
    }

    if (v == CadastroStatus.cadastrando) {
      return cadastrando();
    }

    if (v == CadastroStatus.sucesso) {
      return sucesso();
    }

    if (v == CadastroStatus.error) {
      return error();
    }

    throw Exception('CadastroStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? cadastrando,
      T Function()? sucesso,
      T Function()? error}) {
    final v = this;
    if (v == CadastroStatus.initial && initial != null) {
      return initial();
    }

    if (v == CadastroStatus.cadastrando && cadastrando != null) {
      return cadastrando();
    }

    if (v == CadastroStatus.sucesso && sucesso != null) {
      return sucesso();
    }

    if (v == CadastroStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
