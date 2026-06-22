/// Registration form validation helpers
class ValidationHelper {
  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validate password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{9,12}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  /// Check if all fields are valid
  static bool isFormValid({
    required String email,
    required String password,
    required String phone,
  }) {
    return validateEmail(email) == null &&
        validatePassword(password) == null &&
        validatePhone(phone) == null;
  }
}

/// Shared Preferences key constants for registration form persistence
class RegistrationPersistenceKeys {
  static const String emailKey = 'reg_email';
  static const String passwordKey = 'reg_password';
  static const String phoneKey = 'reg_phone';
  static const String ktpScannedKey = 'reg_ktp_scanned';
}
