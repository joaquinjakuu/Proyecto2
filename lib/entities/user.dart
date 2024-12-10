class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final DateTime birthDate;
  bool isDoctor; // Nueva propiedad

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    this.isDoctor = false, // Por defecto, no es doctor
  });
}
