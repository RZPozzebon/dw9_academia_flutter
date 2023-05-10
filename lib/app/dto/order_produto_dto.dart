// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw9_delivery_app/app/models/produto_model.dart';

class OrderProdutoDto {
  //
  final ProdutoModel produto;
  final int valor;

  OrderProdutoDto({
    required this.produto,
    required this.valor, // Quantidade
  });

  double get totalPreco => valor * produto.price; // Valor X Preço do Produto

  OrderProdutoDto copyWith({
    ProdutoModel? produto,
    int? valor,
  }) {
    return OrderProdutoDto(
      produto: produto ?? this.produto,
      valor: valor ?? this.valor,
    );
  }
}
