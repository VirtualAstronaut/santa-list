class Utils {
  static String? validateEmpty(
    String? value,
  ) {
    if (value?.isEmpty ?? true) return 'Please enter something';

    return null;
  }

  static String capitalize(String value) {
    if (value.isEmpty) return '';
    final capitlized = value[0].toUpperCase();
    final rest = value.substring(1, value.length);
    return '$capitlized$rest';
  }
}
