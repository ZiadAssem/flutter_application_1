class ValidationMixin {
  String? validateEmail(String? value) {
    if (!value!.contains('@')) {
      return 'Invalid email address format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 4 ) {
      return 'Password should consist of at least 4 characters';
    }else if (! value.contains(RegExp(r'[A-Z]'))){
      return 'Password should contain an uppercase letter';
    }
    return null;
  }
  String? validateEmpty(String? value) {
    if (value==null) {
      return 'Please fill the form';
    }
    return null;
  }
  
}
