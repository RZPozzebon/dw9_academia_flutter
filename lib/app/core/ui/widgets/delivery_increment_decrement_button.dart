import 'package:dw9_delivery_app/app/core/ui/sytles/colors_app.dart';
import 'package:dw9_delivery_app/app/core/ui/sytles/text_styles.dart';
import 'package:flutter/material.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final bool _compact;
  final int valor;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.valor,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.valor,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: decrementTap,
              child: Text(
                '-',
                style: context.textStyles.textmedium
                    .copyWith(fontSize: _compact ? 14 : 22, color: Colors.grey),
              ),
            ),
          ),
          Text(
            valor.toString(),
            style: context.textStyles.textRegular.copyWith(
                fontSize: _compact ? 13 : 17,
                color: context.colors?.secundaria),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: incrementTap,
              child: Text('+',
                  style: context.textStyles.textmedium.copyWith(
                      fontSize: _compact ? 14 : 22,
                      color: context.colors?.secundaria)),
            ),
          )
        ],
      ),
    );
  }
}
