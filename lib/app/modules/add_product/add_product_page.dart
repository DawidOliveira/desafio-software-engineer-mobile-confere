import 'package:flutter/material.dart';
import 'package:product_manager/app/modules/add_product/widgets/custom_text_field/custom_text_field_widget.dart';
import 'package:product_manager/app/modules/add_product/widgets/drop_button/drop_button_widget.dart';
import 'package:product_manager/app/modules/add_product/widgets/image_input/image_input_widget.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key, required this.controller, this.productId})
      : super(key: key);
  final HomeController controller;
  final String? productId;

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController promotionPriceController;

  @override
  void initState() {
    super.initState();
    if (widget.productId!.isNotEmpty) {
      final product = widget.controller.getProduct(widget.productId!);
      nameController = TextEditingController(text: product.name);
      priceController = TextEditingController(text: product.price.toString());
      promotionPriceController = TextEditingController(
          text: product.promotionPrice == null
              ? ''
              : product.promotionPrice.toString());
      widget.controller.imgUrl.value = product.imgUrl;
      widget.controller.available.value = product.available;
    } else {
      nameController = TextEditingController();
      priceController = TextEditingController();
      promotionPriceController = TextEditingController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    promotionPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.productId!.isEmpty ? 'Adicione' : 'Edite'} um produto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ImageInputWidget(
                  controller: widget.controller,
                  productId: widget.productId ?? '',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldWidget(
                  label: 'Nome do produto *',
                  textCapitalization: TextCapitalization.sentences,
                  textEditingController: nameController,
                  validator: widget.controller.nameValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        label: 'Preço (R\$) *',
                        keyboardType: TextInputType.number,
                        textEditingController: priceController,
                        validator: widget.controller.priceValidator,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextFieldWidget(
                        label: 'Preço de promoção (R\$)',
                        keyboardType: TextInputType.number,
                        textEditingController: promotionPriceController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropButtonWidget(
                    controller: widget.controller,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        widget.controller.addNewProduct(
                          name: nameController.text,
                          id: widget.productId!.isEmpty
                              ? null
                              : widget.productId,
                          price: double.parse(priceController.text),
                          promotionPrice:
                              promotionPriceController.text.isNotEmpty
                                  ? double.parse(promotionPriceController.text)
                                  : null,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Produto ${widget.productId!.isNotEmpty ? 'editado' : 'adicionado'} com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text(
                        '${widget.productId!.isNotEmpty ? 'Editar' : 'Cadastrar'}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
