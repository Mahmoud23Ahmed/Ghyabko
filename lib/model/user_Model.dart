class UserModel {
  final String? id;
  final String Name;
  final String Email;
  final String Password;
  final String Type;
  final List<String>? subjects;

  const UserModel({
    this.id,
    required this.Email,
    required this.Name,
    required this.Password,
    required this.Type,
    this.subjects,
  });

  toJson() {
    return {
      "Name": Name,
      "Email": Email,
      "password": Password,
      "Type": Type,
      "subjects": subjects,
    };
  }
}
