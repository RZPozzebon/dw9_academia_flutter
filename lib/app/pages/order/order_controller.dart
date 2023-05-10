import 'dart:developer';

import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/pages/order/order_state.dart';
import 'package:dw9_delivery_app/app/repositorio/order/order_repositorio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderController extends Cubit<OrderState> {
  //Atributos
  final OrderRepositorio _orderRepositorio;
  // Construtor
  OrderController(this._orderRepositorio) : super(const OrderState.initial());

  void load(List<OrderProdutoDto> produtos) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final tipoPagamento = await _orderRepositorio.getAllTiposPagamentos();
      emit(state.copyWith(orderProdutos: produtos));

      emit(state.copyWith(
        orderProdutos: produtos,
        status: OrderStatus.loaded,
        tipoPagamento: tipoPagamento,
      ));
    } catch (e, s) {
      log('Erro ao carregar pagina', error: e, stackTrace: s);
      emit(state.copyWith(
          status: OrderStatus.error, errorMessage: 'Erro ao carregar pagina'));
    }
  }

  void incrementProduto(int index) {
    final orders = [...state.orderProdutos];
    final order = orders[index];
    orders[index] = order.copyWith(valor: order.valor + 1);
    emit(
        state.copyWith(orderProdutos: orders, status: OrderStatus.updateOrder));
  }

  void decrementProduto(int index) {
    final orders = [...state.orderProdutos];
    final order = orders[index];
    final orderValor = order.valor;

    if (orderValor == 1) {
      if (state.status != OrderStatus.confirmRemoveProduto) {
        emit(OrderConfirmDeleteProdutoState(
            orderProduto: order,
            index: index,
            status: OrderStatus.confirmRemoveProduto,
            orderProdutos: state.orderProdutos,
            tipoPagamento: state.tipoPagamento,
            errorMessage: state.errorMessage));
      } else {
        orders.removeAt(index);
      }
      return;
    } else {
      orders[index] = order.copyWith(valor: order.valor - 1);
    }

    if (orders.isEmpty) {
      state.copyWith(status: OrderStatus.emptyBag);
      return;
    }
    state.copyWith(orderProdutos: orders, status: OrderStatus.updateOrder);
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  void saveOrder(
      {required TextEditingController endereco,
      required TextEditingController documento,
      int? pagamentoMetodoId}) {
        
      }
}
