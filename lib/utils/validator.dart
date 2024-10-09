class InputValidationUtil {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir une adresse e-mail';
    }
    // Regex simple pour la validation d'e-mail
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez saisir une adresse e-mail valide';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un mot de passe';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un nom';
    }
    if (value.length < 4) {
      return 'Le nom doit contenir au moins 4 caractères';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir un nombre';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Veuillez saisir un nombre valide';
    }
    if (number < 0) {
      return 'Le nombre doit être 0 ou plus';
    }
    return null;
  }

  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir une quantité';
    }
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'Veuillez saisir une quantité valide';
    }
    if (quantity < 1) {
      return 'Le nombre doit être 1 ou plus';
    }
    return null;
  }
}
