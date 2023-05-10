import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:dw9_delivery_app/app/models/produto_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
}

class HomeState extends Equatable {
  //
  final HomeStateStatus status;
  final List<ProdutoModel> produtos;
  final List<OrderProdutoDto> shoppingBag;
  //Construtor
  const HomeState({
    required this.shoppingBag,
    required this.status,
    required this.produtos,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        produtos = const [],
        shoppingBag = const [];

  @override
  List<Object?> get props => [status, produtos, shoppingBag];

  HomeState copyWith({
    HomeStateStatus? status,
    String? errorMessage,
    List<ProdutoModel>? produtos,
    List<OrderProdutoDto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      produtos: produtos ?? this.produtos,
      shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }
}
