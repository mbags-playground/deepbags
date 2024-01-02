import 'package:flutter/material.dart';

import 'package:deepbags/models/base_modal.dart';

class StyledInput extends StatefulWidget {
  InputFieldOptions options;
  TextEditingController controller;
  StyledInput({required this.options, required this.controller, super.key});

  @override
  State<StyledInput> createState() => _StyledInputState();
}

class _StyledInputState extends State<StyledInput> {
  @override
  Widget build(BuildContext context) {
    validator(String? value) {
      var errors = <String>[];
      if (widget.options.validators != null) {
        for (var validator in widget.options.validators!) {
          var result = validator(widget.options.label)!(value ?? "");
          if (result != null) {
            errors.add(result);
          }
        }
      }
      if (errors.isNotEmpty) {
        return errors[0];
      }
      return null;
    }

    switch (widget.options.type) {
      case InputType.number:
        return TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.options.label,
              border: const OutlineInputBorder(),
            ),
            validator: validator);
      case InputType.email:
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.password:
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.date:
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.time:
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.text:
      default:
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
    }
  }
}
