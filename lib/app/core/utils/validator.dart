abstract final class Validator {
  // TODO: document
  static String? requiredField(String? value) =>
      value == null || value == '' ? 'Campo obrigatório' : null;

  // TODO: document
  static String? matchPassword(String? value, String? targetValue) =>
      value == targetValue ? null : 'As senhas não batem.';
}
