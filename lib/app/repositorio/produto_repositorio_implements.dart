import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/models/produto_model.dart';
import 'package:dw9_delivery_app/app/repositorio/produto_repositorio.dart';

import '../core/excepitons/repositorio_exceptions.dart';
import '../core/rest_client/custom_dio.dart';

class ProdutoRepositorioImpl implements ProdutoRepositorio {
  //Variaveis
  final CustomDio dio;
  //Construtor
  ProdutoRepositorioImpl({
    required this.dio,
  });

  // Implementações
  @override
  Future<List<ProdutoModel>> findAllProduto() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProdutoModel>((p) => ProdutoModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      throw RepositorioException(message: 'Erro ao buscar produtos');
    }
  }
}
