import 'package:flutter/material.dart';
import 'package:khan_foods/Constant/App_Colors.dart';


class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    this.validatorFunction,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  TextEditingController controller;
  String? Function(String? value)? validatorFunction;
  IconData prefixIcon;
  IconData? suffixIcon;
  String hintText;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.1,
      width: width * 0.8,
      child: TextFormField(
        validator: validatorFunction,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.iconColor,
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: AppColors.iconColor,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFormFieldBorderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: AppColors.textFormFieldFocusBorderColor),
          ),
        ),
      ),
    );
  }
}