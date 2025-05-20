class MyValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    ).hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!RegExp(r'^[A-Z]').hasMatch(password)) {
      return "Password must start with a capital letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@#\$&*~%^()\-_=+{}[\]|;:",.<>?]').hasMatch(password)) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone is required";
    }
    if (phone.length != 10) {
      return "Please enter a valid 10-digit phone number";
    }
    return null;
  }
}
