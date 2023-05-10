// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/models/pagamento_tipo_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  updateOrder,
  confirmRemoveProduto,
  emptyBag,
  error,
}

class OrderState extends Equatable {
  // Atributos
  final OrderStatus status;
  final List<OrderProdutoDto> orderProdutos;
  final List<PagamentoTipoModel> tipoPagamento;
  final String? errorMessage;

  // Construtor
  const OrderState(
      {required this.status,
      required this.orderProdutos,
      required this.tipoPagamento,
      this.errorMessage});

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProdutos = const [],
        tipoPagamento = const [],
        errorMessage = null;

  double get totalOrder => orderProdutos.fold(
      0.0, (previousValue, element) => previousValue + element.totalPreco);
  @override
  List<Object?> get props =>
      [status, orderProdutos, tipoPagamento, errorMessage];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProdutoDto>? orderProdutos,
    List<PagamentoTipoModel>? tipoPagamento,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProdutos: orderProdutos ?? this.orderProdutos,
      tipoPagamento: tipoPagamento ?? this.tipoPagamento,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class OrderConfirmDeleteProdutoState extends OrderState {
  // Atributos
  final OrderProdutoDto orderProduto;
  final int index;
  // Contrutor
  const OrderConfirmDeleteProdutoState({
    required this.orderProduto,
    required this.index,
    required super.status,
    required super.orderProdutos,
    required super.tipoPagamento,
    super.errorMessage,
  });
}
