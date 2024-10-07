class ApiConstants {
  static const String apiBaseUrl = 'ker-manager-4cb239a4979e.herokuapp.com';
  static const String tokenKey = 'kermanager-token';
  static const String stripeScretKey =
      'sk_test_51NUvqBAlzW5ZDZ2b3YLub6whrxThinoTNFfTN6m3bWX4HJlSJUXPd0BNzdF7KGSx7vCavmzUTvMvymhDEWgYmz6800bjbq721P';
  static const String stripePublishableKey =
      'pk_test_51NUvqBAlzW5ZDZ2bRgoZrqLU6whIgvcTXv53XMqzgH8MrZFKLJQU7DOd4L34qzhPwFhrOgKZux33iX5OURiyi8Mj00vJiEZ2Ce';

  static const Map<String, String> _errorMap = {
    'SERVER_ERROR':
        'Une erreur serveur est survenue. Veuillez réessayer plus tard.',
    'NOT_ALLOWED': 'Vous n\'êtes pas autorisé à effectuer cette action.',
    'EMAIL_ALREADY_EXISTS':
        'Cette adresse e-mail est déjà utilisée. Veuillez en essayer une autre.',
    'INVALID_INPUT':
        'Certaines informations saisies sont incorrectes. Veuillez vérifier les champs et réessayer.',
    'INVALID_CREDENTIALS':
        'Les identifiants sont incorrects. Veuillez vérifier vos informations de connexion.',
    'NOT_ENOUGH_CREDITS':
        'Vous n\'avez pas assez de crédits pour effectuer cette action.',
    'KERMESSE_ALREADY_ENDED': 'La kermesse est déjà terminée.',
    'TOMBOLA_ALREADY_ENDED': 'La tombola est déjà terminée.',
    'NOT_ENOUGH_STOCK': 'Stock insuffisant pour finaliser l\'opération.',
    'IS_NOT_AN_ACTIVITY':
        'L\'activité sélectionnée n\'existe pas. Veuillez en choisir une autre.',
    "TOMBOLA_NOT_ENDED":
        'La kermesse a une tombola en cours. Veuillez la terminer avant de continuer.',
  };

  static String getMessage(String? errorKey) {
    return _errorMap[errorKey] ??
        'Une erreur serveur est survenue. Veuillez réessayer plus tard.';
  }
}
