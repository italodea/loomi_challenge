class FieldValidations {
  static String? validateCPF(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'CPF is empty';
    }

    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11) {
      return 'CPF must have 11 digits';
    }

    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return 'Invalid CPF';
    }

    List<int> numbers = cpf.split('').map((e) => int.parse(e)).toList();

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += numbers[i] * (10 - i);
    }

    int firstDigit = (sum * 10 % 11) % 10;
    if (firstDigit != numbers[9]) {
      return 'Invalid CPF';
    }

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += numbers[i] * (11 - i);
    }

    int secondDigit = (sum * 10 % 11) % 10;
    if (secondDigit != numbers[10]) {
      return 'Invalid CPF';
    }

    return null;
  }

  static String? validateCNPJ(String? cnpj) {
    if (cnpj == null || cnpj.isEmpty) {
      return 'CNPJ is empty';
    }

    cnpj = cnpj.replaceAll(RegExp(r'\D'), '');

    if (cnpj.length != 14) {
      return 'CNPJ must have 14 digits';
    }

    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return 'Invalid CNPJ';
    }

    List<int> numbers = cnpj.split('').map((e) => int.parse(e)).toList();

    int sum = 0;
    List<int> weight1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (int i = 0; i < 12; i++) {
      sum += numbers[i] * weight1[i];
    }

    int firstDigit = (sum % 11 < 2) ? 0 : 11 - (sum % 11);
    if (firstDigit != numbers[12]) {
      return 'Invalid CNPJ';
    }

    sum = 0;
    List<int> weight2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (int i = 0; i < 13; i++) {
      sum += numbers[i] * weight2[i];
    }

    int secondDigit = (sum % 11 < 2) ? 0 : 11 - (sum % 11);
    if (secondDigit != numbers[13]) {
      return 'Invalid CNPJ';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is empty';
    }

    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Invalid email';
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is empty';
    }

    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (!RegExp(r'^\d{10,11}$').hasMatch(phoneNumber)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is empty';
    }

    if (password.length < 6) {
      return 'Password must have at least 6 characters';
    }

    return null;
  }

  static String? validateEqualPassword(String? password1, String? password2) {
    if (password2 == null) {
      return 'This field cannot be empty';
    }

    return password1 != password2 ? 'Passwords do not match' : validatePassword(password2);
  }

  static String? validateMinimumLengh(String? text, String field, int length) {
    if (text == null || text.isEmpty) {
      return '$field is empty';
    }
    if (text.length < length) {
      return '$field must have at least $length characters';
    }

    return null;
  }
}