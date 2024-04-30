class NotificationModel {
  final String? id;
  final String Message;
  final String LecName;
  final String date;
  final String subjectName;

  const NotificationModel({
    this.id,
    required this.Message,
    required this.LecName,
    required this.date,
    required this.subjectName,
  });

  toJson() {
    return {
      "Message": Message,
      "LecName": LecName,
      "date": date,
      "subjectName": subjectName,
    };
  }
}
