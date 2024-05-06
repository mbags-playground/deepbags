import 'package:deepbags/form_models/base_form_model.dart';
import 'package:deepbags/database/models/base_model.dart';
import 'package:deepbags/widgets/button.dart';
import 'package:deepbags/widgets/input.dart';
import 'package:flutter/material.dart';

class ClassToForm<T extends BaseModel> extends StatefulWidget {
  BaseFormModel<T> formClass;
  Function(Map<String, dynamic> value)? onSubmit;
  String actionText;
  String title;
  List<String>? hide;
  Map<String, TextEditingController> controllers = {};
  ClassToForm(
      {super.key,
      required this.formClass,
      required this.onSubmit,
      required this.title,
      required this.actionText,
      this.hide}) {
    formClass.getFieldsOptions().forEach((key, value) {
      if (hide != null && hide!.contains(key)) return;
      controllers[key] = TextEditingController();
      // controllers[key]?.text = formClass.toMap()?[key];
    });
  }

  @override
  State<ClassToForm> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ClassToForm> {
  getFields() {
    return widget.formClass.getFieldsOptions();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = [];
    var fieldOptions = getFields();
    fieldOptions?.forEach((key, value) {
      if (widget.hide != null && widget.hide!.contains(key)) return;
      if (widget.formClass.model?.toJson()[key] != null) {
        widget.controllers[key]!.text =
            widget.formClass.model!.toJson()[key].toString();
      }
      fields.add(StyledInput(
        controller: widget.controllers[key]!,
        options: value,
      ));
    });
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: Wrap(
              runSpacing: 20,
              children: [
                Text(widget.title),
                ...fields,
                if (widget.onSubmit != null)
                  StyledButton(
                      onPressed: () {
                        Map<String, dynamic> values = {};
                        for (var e in widget.controllers.keys) {
                          values[e] = widget.controllers[e]!.text;
                        }
                        if (!formKey.currentState!.validate()) return;

                        if (widget.onSubmit != null) widget.onSubmit!(values);
                      },
                      child: Text(widget.actionText))
              ],
            )),
      ),
    );
  }
}
