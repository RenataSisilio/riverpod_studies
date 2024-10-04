abstract final class Validator {
  static String? requiredField(String? value) =>
      value == null || value == '' ? 'Campo obrigatório' : null;

  static String? matchPassword(String? value, String? targetValue) =>
      value == targetValue ? null : 'As senhas não batem.';
}
