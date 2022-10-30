class ValidationMixin {
  String? validateEmail(String? value) {
    if (!value!.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return 'Password should consist of at least 4 characters';
    }
    return null;
  }
}
