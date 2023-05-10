import 'package:dw9_delivery_app/app/core/extensions/format_mixins.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProdutoTile extends StatelessWidget {
  //Atributos
  final int index;
  final OrderProdutoDto orderProduto;
  // Construtor
  const OrderProdutoTile({
    super.key,
    required this.index,
    required this.orderProduto,
  });

  @override
  Widget build(BuildContext context) {
    final produto = orderProduto.produto;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            produto.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    produto.name,
                    style:
                        context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (orderProduto.valor * produto.price).currentyPTBR,
                      style: context.textStyles.textmedium.copyWith(
                        fontSize: 14,
                        color: context.colors?.secundaria,
                      ),
                    ),
                    DeliveryIncrementDecrementButton.compact(
                      valor: orderProduto.valor,
                      incrementTap: () {
                        context.read<OrderController>().incrementProduto(index);
                      },
                      decrementTap: () {
                        context.read<OrderController>().decrementProduto(index);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
