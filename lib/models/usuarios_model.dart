class Usuario {
  final int id;
  final String avatar;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String country;
  bool isFavorite;

  Usuario({
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.country,
    this.isFavorite = false,
  });
}