import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/models/pagamento_tipo_model.dart';

abstract class OrderRepositorio {
  Future<List<PagamentoTipoModel>> getAllTiposPagamentos();
  Future<void> saveOrder(OrderDto order);
}
