import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomFormField extends StatelessWidget {
   TextEditingController controller=TextEditingController();
   final String hintText;
   final List<TextInputFormatter>? inputFormatters;
   final String? Function(String?)? validator;

  CustomFormField({
    Key? key,
    required this.hintText,
   required this.controller,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller:controller ,
        style: TextStyle(fontSize: 20),
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}