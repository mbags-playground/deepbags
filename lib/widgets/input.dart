import 'dart:convert';

import 'package:deepbags/form_models/input_field.dart';
import 'package:deepbags/database/models/base_model.dart';
import 'package:deepbags/widgets/button.dart';
import 'package:deepbags/widgets/class_form.dart';
import 'package:flutter/material.dart';

class StyledInput extends StatelessWidget {
  InputFieldOptions options;
  TextEditingController controller;
  StyledInput({
    required this.options,
    required this.controller,
    super.key,
  });
  build(BuildContext context) {
    validator(String? value) {
      var errors = <String>[];
      if (options.validators != null) {
        for (var validator in options.validators!) {
          var result = validator(options.label)!(value ?? "");
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

    switch (options.type) {
      case InputType.number:
        return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: options.label,
              border: const OutlineInputBorder(),
            ),
            validator: validator);
      case InputType.email:
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.password:
        return TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: options.label,
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
                labelText: options.label,
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
            labelText: options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
      case InputType.model:
        return ClassToForm(
            formClass: options.model!,
            title: options.label,
            actionText: "",
            hide: const ["id", "Id"],
            onSubmit: (values) {
              print(values);
            });
      case InputType.modelArray:
        return ArrayModelInput(
          controller: controller,
          options: options,
        );
      case InputType.text:
      default:
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: options.label,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
        );
    }
  }
}

class ArrayModelInput extends StatefulWidget {
  TextEditingController controller;
  InputFieldOptions options;
  ArrayModelInput({required this.controller, required this.options});
  @override
  State<ArrayModelInput> createState() => _ArrayModelInputState();
}

class _ArrayModelInputState extends State<ArrayModelInput> {
  List<Map<String, dynamic>> values = [];
  @override
  build(BuildContext context) {
    return Column(
      children: [
        ...values.map((value) => Card(
              child: Dismissible(
                onDismissed: (direction) {
                  values.remove(value);
                  widget.controller.text = json.encode(values);
                },
                key: Key(value.toString()),
                child: Column(
                    children: value.keys
                        .map((k) => Text("$k: ${value[k]}"))
                        .toList()),
              ),
            )),
        ClassToForm(
            formClass: widget.options.model!,
            title: widget.options.label,
            actionText: "",
            hide: const ["id", "Id"],
            onSubmit: (value) {
              setState(() {
                widget.controller.text = json.encode(values);
                values.add(value);
              });
            }),
      ],
    );
  }
}
