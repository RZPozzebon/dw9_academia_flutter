// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/excepitons/repositorio_exceptions.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/models/pagamento_tipo_model.dart';
import 'package:dw9_delivery_app/app/repositorio/order/order_repositorio.dart';

class OrderRepositorioImpl implements OrderRepositorio {
  // Atributos
  final CustomDio dio;

  //Construtor
  OrderRepositorioImpl({
    required this.dio,
  });

  @override
  Future<List<PagamentoTipoModel>> getAllTiposPagamentos() async {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data
          .map<PagamentoTipoModel>((p) => PagamentoTipoModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositorioException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    await dio.auth().post('/orders',data: {
      'products': order.produtos.map((e) => {
        'id' : e.produto.id,
        'amount': e.produto.price,
        'total_price': e.totalPreco
      },).toList(),
      'user_id':'#userAuthRef',
      'address': order.endereco,
      'CPF': order.documento,
      'payment_method_id': order.pagamentoMetodoId
    });
  }
}
