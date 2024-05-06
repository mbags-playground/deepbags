import 'package:deepbags/form_models/base_form_model.dart';
import 'package:deepbags/form_models/input_field.dart';
import 'package:deepbags/database/models/website.dart';

class WebsiteFormModel extends BaseFormModel<Website> {
  WebsiteFormModel({Website? model})
      : super(model: model, inputFieldsOptions: {
          "id": InputFieldOptions(label: 'Id', validators: []),
          "name": InputFieldOptions(label: 'Name'),
          "match": InputFieldOptions(label: 'Match')
        });
}
