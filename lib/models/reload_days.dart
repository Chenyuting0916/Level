class ReloadDays {
  DateTime weekReloadDate;
  DateTime monthReloadDate;
  final String userId;

  ReloadDays({required this.weekReloadDate, required this.monthReloadDate, required this.userId});

  static ReloadDays fromJson(Map<String, dynamic> json) {
    return ReloadDays(
      weekReloadDate: json['weekReloadDate']?.toDate(),
      monthReloadDate: json['monthReloadDate']?.toDate(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "weekReloadDate": weekReloadDate,
      "monthReloadDate": monthReloadDate,
    };
  }
}
