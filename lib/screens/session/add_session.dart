import 'dart:convert';

import 'package:deepbags/database/repositories/session_repository.dart';
import 'package:deepbags/form_models/session_form_model.dart';
import 'package:deepbags/database/models/session.dart';
import 'package:deepbags/widgets/class_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddSession extends StatefulWidget {
  const AddSession({
    super.key,
  });

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Builder(builder: (context) {
      return ClassToForm(
          onSubmit: (values) {
            values['websites'] = json.decode(values['websites']);
            var session = SessionModel.fromJson(values);
            SessionRepository().saveToStorage(session);
            context.push("/filters/all");
          },
          title: "Create a  website filter",
          actionText: "Create",
          hide: const ["id", "websites"],
          formClass: SessionFormModel(model: SessionModel()));
    }));
  }
}
