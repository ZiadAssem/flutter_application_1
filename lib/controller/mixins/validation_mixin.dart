// This file contains all the validation methods for the form fields

// It validates the email, password, birth month and birth year
// It also validates if the fields are empty
// before the form is sent to the server

class ValidationMixin {

// validates if email contains @
  String? validateEmail(String? value) {
    if (!value!.contains('@')) {
      return 'Invalid email address format';
    }
    return null;
  }

// validates if password is at least 4 characters and contains an uppercase letter
  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return 'Password should consist of at least 4 characters';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password should contain an uppercase letter';
    }
    return null;
  }

// validates if the field is empty
  String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return 'Please fill the form';
    }
    return null;
  }

// validates if birth month between 1 and 12
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
// validates if bith year is over 1900
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
