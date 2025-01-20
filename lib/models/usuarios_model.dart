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
    required this.isFavorite,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      avatar: json['avatar'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      country: json['country'],
      isFavorite: json['is_favorite'],
    );
  }
}