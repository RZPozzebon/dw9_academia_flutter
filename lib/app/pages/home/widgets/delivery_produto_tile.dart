import 'package:dw9_delivery_app/app/core/extensions/format_mixins.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:dw9_delivery_app/app/models/produto_model.dart';
import 'package:provider/provider.dart';

class DeliveryProdutoTile extends StatelessWidget {
  //Atributos
  final ProdutoModel produto;
  final OrderProdutoDto? orderProduto;

  const DeliveryProdutoTile({
    super.key,
    required this.produto,
    required this.orderProduto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProdutoResult = await Navigator.of(context).pushNamed(
            '/produtoDetalhe',
            arguments: {'produto': produto, 'order': orderProduto});

        if (orderProdutoResult != null) {
          controller.addOrUpdateBag(orderProdutoResult as OrderProdutoDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.name,
                      style: context.textStyles.textExtraBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.description,
                      style:
                          context.textStyles.textRegular.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.price.currentyPTBR,
                      style: context.textStyles.textmedium.copyWith(
                        fontSize: 11,
                        color: context.colors?.secundaria,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: produto.image,
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
