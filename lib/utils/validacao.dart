bool camposPreenchidos(String email, String senha) {
  return email.trim().isNotEmpty && senha.trim().isNotEmpty;
}