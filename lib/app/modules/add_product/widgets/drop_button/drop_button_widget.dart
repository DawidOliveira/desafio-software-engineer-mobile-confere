import 'package:flutter/material.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';

class DropButtonWidget extends StatefulWidget {
  const DropButtonWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  _DropButtonWidgetState createState() => _DropButtonWidgetState();
}

class _DropButtonWidgetState extends State<DropButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Disponível para venda:'),
        StreamBuilder<int?>(
            stream: widget.controller.available,
            builder: (context, snapshot) {
              return DropdownButton<int?>(
                value: snapshot.data,
                onChanged: (value) {
                  widget.controller.setAvailable = value;
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('Sim'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('Não'),
                    value: 0,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
