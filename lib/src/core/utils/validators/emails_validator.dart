String? emailValidator(String? value) {
  // Vérifier si le champ est vide
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer une adresse e-mail.';
  }

  // Expression régulière pour valider une adresse e-mail
  final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  if (!emailRegex.hasMatch(value)) {
    return 'Veuillez entrer une adresse e-mail valide.';
  }

  // Si tout est valide
  return null;
}
