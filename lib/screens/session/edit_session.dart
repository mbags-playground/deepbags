import 'dart:convert';

import 'package:deepbags/database/repositories/session_repository.dart';
import 'package:deepbags/form_models/session_form_model.dart';
import 'package:deepbags/database/models/session.dart';
import 'package:deepbags/widgets/class_form.dart';
import 'package:deepbags/widgets/loading.dart';
import 'package:flutter/material.dart';

class UpdateSession extends StatefulWidget {
  int id;
  UpdateSession({
    required this.id,
    super.key,
  });

  @override
  State<UpdateSession> createState() => _UpdateSessionState();
}

class _UpdateSessionState extends State<UpdateSession> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is calwidgets.
    return FutureBuilder(
        future: SessionRepository().getSessionById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ClassToForm(
                onSubmit: (values) {
                  values['websites'] = json.decode(values['websites']);
                  var session = SessionModel.fromJson(values);
                  SessionRepository().updateSession(session);
                },
                title: "Create a  website filter",
                actionText: "Create",
                hide: const ["id", "websites"],
                formClass: SessionFormModel(model: snapshot.data));
          }
          return LoadingWidget();
        });
  }
}
