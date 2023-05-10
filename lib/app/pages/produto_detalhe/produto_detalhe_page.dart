import 'package:auto_size_text/auto_size_text.dart';
import 'package:dw9_delivery_app/app/core/extensions/format_mixins.dart';
import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appBar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/models/produto_model.dart';
import 'package:dw9_delivery_app/app/pages/produto_detalhe/produto_datelhe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProdutoDetalhePage extends StatefulWidget {
  // Atributos
  final ProdutoModel produto;
  final OrderProdutoDto? order;

  //Construtor
  const ProdutoDetalhePage(
      {super.key, required this.produto, required this.order});

  @override
  State<ProdutoDetalhePage> createState() => _ProdutoDetalhePageState();
}

class _ProdutoDetalhePageState
    extends BaseState<ProdutoDetalhePage, ProdutoDetalheController> {
  @override
  void initState() {
    super.initState();
    final valor = widget.order?.valor ?? 1;
    controller.initial(valor, widget.order != null);
  }

  void _showConfirmaDelete(int valor) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja exluir o produto?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style:
                      context.textStyles.textbold.copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(
                    OrderProdutoDto(
                      produto: widget.produto,
                      valor: valor,
                    ),
                  );
                },
                child: Text(
                  'Confirmar',
                  style: context.textStyles.textbold,
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentualHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.produto.image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.produto.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(widget.produto.description),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                    width: context.percentualWidth(.5),
                    height: 68,
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<ProdutoDetalheController, int>(
                      builder: (context, valor) {
                        return DeliveryIncrementDecrementButton(
                          decrementTap: () {
                            controller.decrement();
                          },
                          incrementTap: () {
                            controller.increment();
                          },
                          valor: valor,
                        );
                      },
                    )),
                Container(
                  width: context.percentualWidth(.5),
                  height: 68,
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<ProdutoDetalheController, int>(
                    builder: (context, valor) {
                      return ElevatedButton(
                        style: valor == 0
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.red)
                            : null,
                        onPressed: () {
                          if (valor == 0) {
                            _showConfirmaDelete(valor);
                          } else {
                            Navigator.of(context).pop(
                              OrderProdutoDto(
                                produto: widget.produto,
                                valor: valor,
                              ),
                            );
                          }
                        },
                        child: Visibility(
                          visible: valor > 0,
                          replacement: Text(
                            'Excluir Produto',
                            style: context.textStyles.textExtraBold,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Adiconar',
                                style: context.textStyles.textExtraBold
                                    .copyWith(fontSize: 13),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  (widget.produto.price * valor).currentyPTBR,
                                  maxFontSize: 13,
                                  minFontSize: 5,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
