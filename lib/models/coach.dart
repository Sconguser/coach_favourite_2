class Coach{
  final int id;
  final String email;
  final String name;
  final String lastName;
  Coach({required this.id, required this.email, required this.name, required this.lastName});
  factory Coach.fromJson(Map<String, dynamic> body) {
    return Coach(
        name: body['name'],
        lastName: body['lastname'],
        email: body['email'],
        id: body['id']);
  }
}