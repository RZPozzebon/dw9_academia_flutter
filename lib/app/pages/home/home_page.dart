import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/shopping_bag_widget.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ui/widgets/delivery_appBar.dart';
import 'widgets/delivery_produto_tile.dart';

class HomePage extends StatefulWidget {
  //
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              //Text(state.shoppingBag.length.toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: state.produtos.length,
                  itemBuilder: (context, index) {
                    final produto = state.produtos[index];
                    final orders = state.shoppingBag
                        .where((order) => order.produto == produto);
                    return DeliveryProdutoTile(
                      produto: produto,
                      orderProduto: orders.isNotEmpty ? orders.first : null,
                    );
                  },
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShoppingBagWidget(bag: state.shoppingBag),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
