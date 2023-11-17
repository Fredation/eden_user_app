var regex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class Validators {
  static String? validateEmail(String? email) {
    if (!regex.hasMatch(email!)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  static String? validatePhonenumber(String? str) {
    RegExp regExp = RegExp(
      r"^\d{10,11}$",
    );
    if (!regExp.hasMatch(str!)) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password field cannot be empty";
    } else if (value.length < 6) {
      return "Password must be 6 characters or more";
    } else {
      return null;
    }
  }
}
