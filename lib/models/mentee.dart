class Mentee{
  final int id;
  final String email;
  final String name;
  final String lastName;
  Mentee({required this.id, required this.email, required this.name, required this.lastName});
  factory Mentee.fromJson(Map<String, dynamic> body) {
    return Mentee(
        name: body['name'],
        lastName: body['lastname'],
        email: body['email'],
        id: body['id']);
  }
}