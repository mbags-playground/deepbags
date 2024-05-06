import 'package:deepbags/form_models/input_field.dart';
import 'package:deepbags/database/models/base_model.dart';
import 'package:flutter/material.dart';

class BaseFormModel<T extends BaseModel> {
  T? model;
  Map<String, InputFieldOptions> inputFieldsOptions = {};
  static Map<String, InputFieldOptions> mergeToInputOptions(
      {required Map<String, InputFieldOptions> input,
      required Map<String, InputFieldOptions> target}) {
    if (input != null) {
      for (String? key in target.keys) {
        // merge targetedFieldsOptions with inputFields
        if (input.containsKey(key)) {
          input[key!] = target[key]!;
        }
      }
    }
    return input;
  }

  Map<String, InputFieldOptions> getFieldsOptions() {
    return inputFieldsOptions;
  }

  updateFieldsOptions(Map<String, InputFieldOptions> targetedFieldsOptions) {
    inputFieldsOptions = BaseFormModel.mergeToInputOptions(
        input: getFieldsOptions(), target: targetedFieldsOptions);
  }

  BaseFormModel({this.model, this.inputFieldsOptions = const {}});
}
