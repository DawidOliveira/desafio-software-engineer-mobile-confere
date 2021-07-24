import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    required this.label,
    this.textEditingController,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final String label;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: validator,
    );
  }
}
