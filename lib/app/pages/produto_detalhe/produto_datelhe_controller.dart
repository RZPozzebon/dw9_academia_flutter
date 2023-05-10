import 'package:bloc/bloc.dart';

class ProdutoDetalheController extends Cubit<int> {
  //
  late final bool _hasOrder;
  ProdutoDetalheController() : super(1);

  void initial(int valor, bool hasOrder) {
    _hasOrder = hasOrder;
    emit(valor);
  }

  void increment() => emit(state + 1);
  void decrement() {
    if (state > (_hasOrder ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
