import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:product_manager/app/core/app_text_styles.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    required this.name,
    required this.price,
    this.promotionPrice,
    this.imgUrl,
    this.discountPercentage,
    required this.id,
    required this.controller,
    required this.available,
  }) : super(key: key);

  final String id;
  final String name;
  final double price;
  final double? promotionPrice;
  final String? imgUrl;
  final double? discountPercentage;
  final bool available;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/add-product', arguments: {
            'id': id,
            'controller': Modular.get<HomeController>(),
          });
        },
        leading: Hero(
          tag: 'tag-$id',
          child: CircleAvatar(
            foregroundImage: imgUrl != null && imgUrl!.isNotEmpty
                ? FileImage(File(imgUrl!))
                : null,
          ),
        ),
        title: Text(name),
        subtitle: RichText(
          text: TextSpan(
            text: '${available ? 'R\$ $price' : 'Produto indisponível'}',
            style: AppTextStyles.subtitle.copyWith(
              color: promotionPrice != null ? Colors.grey : Colors.green,
              decoration: promotionPrice != null && available
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            children: <InlineSpan>[
              if (promotionPrice != null && available)
                TextSpan(
                  text: ' - ',
                  style: AppTextStyles.subtitle.copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
              if (promotionPrice != null && available)
                TextSpan(
                    text: 'R\$ $promotionPrice',
                    style: AppTextStyles.subtitle.copyWith(
                      decoration: TextDecoration.none,
                      color: Colors.green,
                    ),
                    children: [
                      TextSpan(
                          text:
                              " (${(discountPercentage! * 100).floor()}% de desconto)"),
                    ])
            ],
          ),
        ),
      ),
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 1 / 5,
      actions: [
        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          caption: 'Remover',
          onTap: () {
            Alert(
              context: context,
              title: 'Tem certeza que deseja apagar?',
              type: AlertType.warning,
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: const Text(
                    "Não",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                ),
                DialogButton(
                  child: const Text(
                    "Sim",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    await controller.removeProduct(id: id);
                    Navigator.pop(context);
                  },
                  width: 120,
                ),
              ],
            ).show();
          },
        ),
      ],
    );
  }
}
