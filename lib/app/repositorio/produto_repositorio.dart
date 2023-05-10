import '../models/produto_model.dart';

abstract class ProdutoRepositorio {
  Future<List<ProdutoModel>> findAllProduto();
}
