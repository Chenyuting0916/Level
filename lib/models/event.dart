class Event {
  final String eventName;
  final DateTime eventDate;
  final String userId;

  Event(
      {required this.eventName, required this.eventDate, required this.userId});

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      eventName: json['eventName'],
      eventDate: json['eventDate']?.toDate(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "eventDate": eventDate,
      "eventName": eventName
    };
  }
}
