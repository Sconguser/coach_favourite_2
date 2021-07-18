String? inputValidator(value, String errorMessage) {
  if (value.isEmpty || value == null) {
    return errorMessage;
  }
  return null;
}

String? passwordValidator(value) {
  int requiredLength = 6;
  if (value.length < requiredLength || value == null) {
    return 'Enter password at least $requiredLength characters long';
  }
  return null;
}

String? passwordConfirmationValidator(value, value2) {
  int requiredLength = 6;
  if (value.length < requiredLength || value == null) {
    return 'Enter password at least $requiredLength characters long';
  }
  if (value != value2) {
    return 'Passwords do not match';
  }
  return null;
}