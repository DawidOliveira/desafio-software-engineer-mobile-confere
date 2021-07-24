import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({
    Key? key,
    required this.controller,
    this.productId = "",
  }) : super(key: key);

  final HomeController controller;
  final String? productId;

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<String?>(
          stream: widget.controller.imgUrl,
          builder: (context, snapshot) {
            return Hero(
              tag: 'tag-${widget.productId}',
              child: CircleAvatar(
                foregroundImage: snapshot.data != null && snapshot.data != ""
                    ? FileImage(File(snapshot.data!))
                    : null,
                radius: 45,
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: () async {
            await widget.controller.saveImage();
          },
          icon: const Icon(Icons.camera),
          label: const Text('Adicionar uma imagem'),
        ),
      ],
    );
  }
}
