class NotificationModel {
  final String? id;
  final String Message;
  final String LecName;
  final String date;
  final String subjectName;
  final String locationLatitude;
  final String locationLongitude;

  const NotificationModel({
    this.id,
    required this.Message,
    required this.LecName,
    required this.date,
    required this.subjectName,
    required this.locationLatitude,
    required this.locationLongitude,
  });

  toJson() {
    return {
      "Message": Message,
      "LecName": LecName,
      "date": date,
      "subjectName": subjectName,
      "locationLatitude": locationLatitude,
      "locationLongitud": locationLongitude,
    };
  }
}
