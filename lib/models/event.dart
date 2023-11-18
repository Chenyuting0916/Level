class Event {
  String eventName;
  final DateTime eventDate;
  final String userId;
  bool isCompleted;

  Event(
      {required this.eventName,
      required this.eventDate,
      required this.userId,
      required this.isCompleted});

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
        eventName: json['eventName'],
        eventDate: json['eventDate']?.toDate(),
        userId: json['userId'],
        isCompleted: json['isCompleted'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "eventDate": eventDate,
      "eventName": eventName,
      "isCompleted": isCompleted
    };
  }
}
