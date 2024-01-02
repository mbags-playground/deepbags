import 'package:deepbags/models/base_modal.dart';
import 'package:deepbags/widgets/Input.dart';
import 'package:deepbags/widgets/button.dart';
import 'package:flutter/material.dart';

class ClassToForm extends StatefulWidget {
  AbstractModal formClass;
  Function(AbstractModal value) onSubmit;
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
    formClass.getFieldsOptions()?.forEach((key, value) {
      if (hide != null && hide!.contains(key)) return;
      controllers[key] = TextEditingController();
      // controllers[key]?.text = formClass.toMap()?[key];
    });
  }

  @override
  State<ClassToForm> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ClassToForm> {
  @override
  Widget build(BuildContext context) {
    List<Widget> fields = [];
    widget.formClass.getFieldsOptions()?.forEach((key, value) {
      if (widget.hide != null && widget.hide!.contains(key)) return;
      if (widget.formClass.toMap()?[key] != null)
        widget.controllers[key]!.text =
            widget.formClass.toMap()![key].toString();
      fields.add(StyledInput(
        controller: widget.controllers[key]!,
        options: value,
      ));
    });
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            child: Wrap(
          runSpacing: 20,
          children: [
            Text(widget.title),
            ...fields,
            StyledButton(onPressed: () => {}, child: Text(widget.actionText))
          ],
        )),
      ),
    );
  }
}
