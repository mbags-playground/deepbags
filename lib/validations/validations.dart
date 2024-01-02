String? Function(String?) Function(String) isRequired() {
  return (String fieldName) =>
      (value) => value!.isEmpty ? '"$fieldName" is required' : null;
}

String? Function(String?) Function(String) isGreaterThan(double min) {
  return (String fieldName) => (value) => (min <= double.parse(value ?? "0"))
      ? '"$fieldName" should be greater than $min'
      : null;
}
