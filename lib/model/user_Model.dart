class UserModel {
  final String? id;
  final String Name;
  final String Email;
  final String Password;
  final String? ImgProf;
  final String Type;

  const UserModel({
    this.id,
    required this.Email,
    required this.Name,
    required this.Password,
    this.ImgProf,
    required this.Type,
  });

  toJson() {
    return {
      "Name": Name,
      "Email": Email,
      "password": Password,
      "imgeProf": ImgProf,
      "Type": Type
    };
  }
}
