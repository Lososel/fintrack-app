class ValidationHelper {
  // Email validation regex
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Minimum password length
  static const int _minPasswordLength = 6;

  /// Validates email format
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!_emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates password strength
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < _minPasswordLength) {
      return 'Password must be at least $_minPasswordLength characters long';
    }

    return null;
  }

  /// Validates password for login (just checks if not empty)
  static String? validatePasswordForLogin(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  /// Validates name
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }

    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  /// Gets password strength indicator
  static PasswordStrength getPasswordStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrength.none;
    }

    if (password.length < _minPasswordLength) {
      return PasswordStrength.weak;
    }

    // Simple strength calculation based on length
    if (password.length < 8) {
      return PasswordStrength.weak;
    } else if (password.length < 12) {
      // Check for variety of characters for medium strength
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      bool hasNumber = password.contains(RegExp(r'\d'));
      
      int variety = 0;
      if (hasLowercase) variety++;
      if (hasUppercase) variety++;
      if (hasNumber) variety++;
      
      return variety >= 2 ? PasswordStrength.medium : PasswordStrength.weak;
    } else {
      return PasswordStrength.strong;
    }
  }
}

enum PasswordStrength {
  none,
  weak,
  medium,
  strong,
}

