enum InputType { text, number, email, password, date, time, select, checkbox }

class Options {
  String? label;
  String? value;
  Options({this.label, this.value});
  static mergeTwoOptions(Options a, Options b) {
    return Options(label: a.label ?? b.label, value: a.value ?? b.value);
  }
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
  List<String> options; // Added options property

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
      this.options = const []});
  static InputFieldOptions mergeTwInputOptions(
      InputFieldOptions a, InputFieldOptions b) {
    return InputFieldOptions(
        label: a.label ?? b.label,
        type: a.type ?? b.type,
        placeholder: a.placeholder ?? b.placeholder,
        helperText: a.helperText ?? b.helperText,
        prefixIcon: a.prefixIcon ?? b.prefixIcon,
        suffixIcon: a.suffixIcon ?? b.suffixIcon,
        obscureText: a.obscureText ?? b.obscureText,
        readOnly: a.readOnly ?? b.readOnly,
        enabled: a.enabled ?? b.enabled,
        validators: a.validators ?? b.validators,
        options: Options.mergeTwoOptions(
                Options(label: a.label, value: a.value),
                Options(label: b.label, value: b.value))
            .toList());
  }
}
