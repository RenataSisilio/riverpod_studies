abstract final class Validator {
  /// Validates whether a field is empty.
  static String? requiredField(String? value) =>
      value == null || value == '' ? 'Campo obrigatório' : null;

  /// Validates whether the confirmation matches the typed passowrd.
  static String? matchPassword(String? value, String? targetValue) =>
      value == targetValue ? null : 'As senhas não batem.';
}
