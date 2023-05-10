// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/excepitons/autenticacao_excepetions.dart';
import 'package:dw9_delivery_app/app/core/excepitons/repositorio_exceptions.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/autenticacao_model.dart';
import 'package:dw9_delivery_app/app/repositorio/autenticacao/autenticacao_repositorio.dart';

class AutenticacaoRepositorioImpl implements AutenticacaoRepositorio {
  //
  final CustomDio dio;
  //Construtor
  AutenticacaoRepositorioImpl({
    required this.dio,
  });
  @override
  Future<AutenticacaoModel> login(String email, String senha) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': senha,
      });
      return AutenticacaoModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        throw AutenticacaoExcepetions;
      }
      //log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositorioException(message: 'Erro ao relaizar login');
    }
  }

  @override
  Future<void> register(String nome, String email, String senha) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': nome,
        'email': email,
        'password': senha,
      });
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        throw AutenticacaoExcepetions;
      }
      //log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositorioException(message: 'Erro ao registrar login');
    }
  }
}
