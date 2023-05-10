// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';

class OrderDto {
  //Atributos
  List<OrderProdutoDto> produtos;
  String endereco;
  String documento;
  int pagamentoMetodoId;

  // Construtor
  OrderDto({
    required this.produtos,
    required this.endereco,
    required this.documento,
    required this.pagamentoMetodoId,
  });
}
