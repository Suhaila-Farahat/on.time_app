import 'package:flutter/material.dart';
import 'package:to_to_app/Constants.dart';

Widget CustomTextFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required validate,
  required String label,
  required IconData prefix,
  onTap,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: validate,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: defaultFont
          ),
          prefixIcon: Icon(prefix),
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 3)),
        ),
        style: TextStyle(
            color: Colors.white, letterSpacing: 1.5, fontSize: 17),
      ),
    );
