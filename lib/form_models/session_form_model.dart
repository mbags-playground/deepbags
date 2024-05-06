import 'package:deepbags/form_models/base_form_model.dart';
import 'package:deepbags/form_models/input_field.dart';
import 'package:deepbags/form_models/website_form_model.dart';
import 'package:deepbags/database/models/session.dart';
import 'package:flutter/material.dart';

class SessionFormModel extends BaseFormModel<SessionModel> {
  SessionFormModel({SessionModel? model})
      : super(model: model, inputFieldsOptions: {
          "id": InputFieldOptions(label: 'Id', validators: []),
          "name": InputFieldOptions(label: 'Name', validators: [
            (value) => (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                }
          ]),
          "startTime": InputFieldOptions(
              label: 'Start time',
              type: InputType.time,
              validators: [
                (value) => (value) {
                      if (value!.isEmpty) {
                        return 'Start time is required';
                      }
                      return null;
                    }
              ]),
          "lengsthInMinutes": InputFieldOptions(
              label: 'Length',
              prefixIcon: const Icon(Icons.lock),
              validators: [
                (value) => (value) {
                      if (value!.isEmpty) {
                        return 'Length must be atleast 1 is required';
                      }
                      return null;
                    }
              ]),
          "mode": InputFieldOptions(label: 'Mode'),
        });
}
