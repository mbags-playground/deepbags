abstract class AbstractModal {
  Map<String, InputFieldOptions>? getFieldsOptions();
  Map<String, dynamic>? toMap();
  String toJson();
}

enum InputType { text, number, email, password, date, time, select, checkbox }

class Options {
  String? label;
  String? value;
  Options({this.label, this.value});
}

class InputFieldOptions {
  String label;
  InputType type;
  String? placeholder;
  String? helperText;
  String? prefixIcon;
  String? suffixIcon;
  bool? obscureText;
  bool? readOnly;
  bool? enabled;
  List<String? Function(String?) Function(String)>? validators;
  List<String>? options; // Added options property

  InputFieldOptions(
      {required this.label,
      this.type = InputType.text,
      this.placeholder,
      this.helperText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.readOnly,
      this.enabled,
      this.validators,
      this.options}); // Added options parameter
}
