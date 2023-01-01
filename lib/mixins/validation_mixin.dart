class ValidationMixin {
  String? validateEmail(String? value) {
    if (!value!.contains('@')) {
      return 'Invalid email address format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return 'Password should consist of at least 4 characters';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password should contain an uppercase letter';
    }
    return null;
  }

  String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return 'Please fill the form';
    }
    return null;
  }

  String? validateBirthMonth(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a valid month';
    } else {
      final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
      if (numericRegex.hasMatch(value)) {
        if (int.parse(value) < 1 || int.parse(value) > 12) {
          return 'Please enter a valid month';
        }
        return null;
      }
      return 'Please enter a valid month';
    }
  }

  String? validateBirthYear(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a valid year';
    } else {
      final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
      if (numericRegex.hasMatch(value)) {
        if (int.parse(value) < 1900) {
          return 'Please enter a valid year';
        }
        return null;
      }
      return 'Please enter a valid year';
    }
  }
}
