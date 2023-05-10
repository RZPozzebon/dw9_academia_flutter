import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/repositorio/produto_repositorio.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  //
  final ProdutoRepositorio _produtoRepositorio;
  //
  HomeController(
    this._produtoRepositorio,
  ) : super(const HomeState.initial());

  Future<void> loadProdutos() async {
    //Muda estado da tela
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(Duration(seconds: 2));
      final produto = await _produtoRepositorio.findAllProduto();
      // Muda estado e passa o produto
      emit(state.copyWith(status: HomeStateStatus.loaded, produtos: produto));
    } catch (e) {
      log(1);
    }
  }

  void addOrUpdateBag(OrderProdutoDto orderProduto) {
    final shoppingBag = [...state.shoppingBag];

    final orderIndex = shoppingBag
        .indexWhere((orderP) => orderP.produto == orderProduto.produto);

    if (orderIndex > -1) {
      if (orderProduto.valor == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduto;
      }
    } else {
      shoppingBag.add(orderProduto);
    }
    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProdutoDto> updateBag) {
    emit(state.copyWith(shoppingBag: updateBag));
  }
}
