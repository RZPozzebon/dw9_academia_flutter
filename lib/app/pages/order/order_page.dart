import 'package:dw9_delivery_app/app/core/extensions/format_mixins.dart';
import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appBar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/order_fields.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/pagamento_tipo_field.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/dto/order_produto_dto.dart';
import 'package:dw9_delivery_app/app/models/pagamento_tipo_model.dart';
import 'package:dw9_delivery_app/app/pages/order/order_controller.dart';
import 'package:dw9_delivery_app/app/pages/order/order_produto_tile.dart';
import 'package:dw9_delivery_app/app/pages/order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  //Atributos
  final formKey = GlobalKey<FormState>();
  final enderecoEC = TextEditingController();
  final documentoEC = TextEditingController();
  int? tiposPagamentoId;
  final pagamentTipoValido = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final produtos =
        ModalRoute.of(context)!.settings.arguments as List<OrderProdutoDto>;

    controller.load(produtos);
  }

  // Metodo
  void _showConfirmDeleteProduto(OrderConfirmDeleteProdutoState state) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Deseja exluir o produto ${state.orderProduto.produto.name}?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.cancelDeleteProcess();
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
                  controller.decrementProduto(state.index);
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
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro nao informado');
            },
            confirmRemoveProduto: () {
              hideLoader();
              if (state is OrderConfirmDeleteProdutoState) {
                _showConfirmDeleteProduto(state);
              }
            },
            emptyBag: () {
              showInfo('Sua sacola está vazia');
              Navigator.pop(context, <OrderProdutoDto>[]);
            });
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProdutos);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppBar(),
          body: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyles.textTitle
                              .copyWith(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () => controller.emptyBag(),
                            icon: Image.asset('assets/images/trashRegular.png'))
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProdutoDto>>(
                  selector: (state) => state.orderProdutos,
                  builder: (context, orderProdutos) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProdutos.length,
                        (context, index) {
                          final orderProduto = orderProdutos[index];
                          return Column(
                            children: [
                              OrderProdutoTile(
                                index: index,
                                orderProduto: orderProduto,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total do pedido',
                            style: context.textStyles.textExtraBold
                                .copyWith(fontSize: 14),
                          ),
                          BlocSelector<OrderController, OrderState, double>(
                            selector: (state) => state.totalOrder,
                            builder: (context, totalOrder) {
                              return Text(
                                totalOrder.currentyPTBR,
                                style: context.textStyles.textExtraBold
                                    .copyWith(fontSize: 14),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderFields(
                      title: 'Endereço de entrega',
                      controller: enderecoEC,
                      validator: Validatorless.required('Endereço Obrigatório'),
                      hinttext: 'Digete um endereço',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderFields(
                      title: 'CPF',
                      controller: documentoEC,
                      validator: Validatorless.required('CPF Obrigatório'),
                      hinttext: 'Digete um CPF',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocSelector<OrderController, OrderState,
                        List<PagamentoTipoModel>>(
                      selector: (state) => state.tipoPagamento,
                      builder: (context, tipoPagamentos) {
                        return ValueListenableBuilder(
                            valueListenable: pagamentTipoValido,
                            builder: (_, pagamentTipoValidoValue, child) {
                              return PagamentoTipoField(
                                tiposPagamentos: tipoPagamentos,
                                valueChanged: (value) {
                                  tiposPagamentoId = value;
                                },
                                valido: pagamentTipoValidoValue,
                                valueSelected: tiposPagamentoId.toString(),
                              );
                            });
                      },
                    ),
                  ]),
                ),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DeliveryButton(
                          width: double.infinity,
                          height: 40,
                          label: 'FINALIZA',
                          onPressed: () {
                            final valido =
                                formKey.currentState?.validate() ?? false;
                            final tipoPagamentoSelecionado =
                                tiposPagamentoId != null;
                            pagamentTipoValido.value = tipoPagamentoSelecionado;
                            if (valido && tipoPagamentoSelecionado) {
                              controller.saveOrder(                                 
                                  endereco: enderecoEC,
                                  documento: documentoEC,
                                  pagamentoMetodoId: tiposPagamentoId);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
