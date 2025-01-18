import 'package:flutter/material.dart';
/*
 * Widget para mostrar una tarjeta de usuario con información básica y un botón de favorito
*/
class UsuariosCard extends StatelessWidget {
  final String avatar;
  final String firstName;
  final String lastName;
  final String gender;
  final String country;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;

  const UsuariosCard({
    Key? key,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.country,
    required this.isFavorite,
    this.onFavoriteTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 206, 219, 246),
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/avatars/$avatar.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(lastName),
                ],
              ),
            ),
            Icon(
              gender == "Male" ? Icons.male : Icons.female,
              color: gender == "Male" ? Colors.blue : Colors.pink,
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/flags/$country.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border_outlined,
                color: Colors.yellow[700],
              ),
              onPressed: onFavoriteTap,
            ),
          ],
        ),
      ),
    );
  }
}