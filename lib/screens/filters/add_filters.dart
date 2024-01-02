import 'package:deepbags/models/website_filter.dart';
import 'package:deepbags/widgets/class_form.dart';
import 'package:flutter/material.dart';

class AddFlitter extends StatefulWidget {
  const AddFlitter({
    super.key,
  });

  @override
  State<AddFlitter> createState() => _AddFlitterState();
}

class _AddFlitterState extends State<AddFlitter> {
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      child: Center(child: Builder(builder: (context) {
        return ClassToForm(
            onSubmit: (value) => {},
            title: "Create a  website filter",
            actionText: "Create",
            hide: const ["id"],
            formClass: WebsiteFilter());
      })),
    );
  }
}
