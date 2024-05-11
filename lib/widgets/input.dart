import 'dart:convert';

import 'package:deepbags/widgets/button.dart';
import 'package:flutter/material.dart';

enum InputType { text, number, email, password, time, date }

class StyledInput extends StatelessWidget {
  TextEditingController controller;
  List<Function(String value)> validators = [];
  InputType inputType;
  String label;
  StyledInput({
    required this.controller,
    this.label = "",
    this.inputType = InputType.text,
    this.validators = const [],
    super.key,
  });
  build(BuildContext context) {
    var validator = (String? value) {
      var errors = <String>[];
      for (var validator in validators) {
        var result = validator(label)(value ?? "");
        if (result != null) {
          errors.add(result);
        }
      }
      if (errors.isNotEmpty) {
        return errors[0];
      }
      return null;
    };

    switch (inputType) {
      case InputType.number:
        return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator: validator);
      case InputType.email:
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.password:
        return TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.time:
        return Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              readOnly: true,
              validator: validator,
            ),
            StyledButton(
                onPressed: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  controller.text = time!.format(context);
                },
                child: Text("Select time"))
          ],
        );
      case InputType.date:
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.text:
      default:
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
    }
  }
}
