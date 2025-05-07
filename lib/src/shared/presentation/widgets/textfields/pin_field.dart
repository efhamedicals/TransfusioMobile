import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';

class PinField extends StatelessWidget {
  final TextEditingController controller;
  const PinField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.getScreenWidth(context) / 7.2,
      height: Dimensions.getScreenWidth(context) / 7.2,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        style: Theme.of(context).textTheme.titleLarge,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: "-",
          hintStyle: const TextStyle(fontSize: 30),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
