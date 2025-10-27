class NotificationModel {
  final int notificationId;
  final int replacementId;
  final String? subject;
  final String? description;
  final bool isViewed;

  NotificationModel({
    required this.notificationId,
    required this.replacementId,
    this.subject,
    this.description,
    this.isViewed = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationid'],
      replacementId: json['replacementid'],
      subject: json['categoryname'],
      description: json['content'],
      isViewed: json['isOpen'] == true ? true : false,
    );
  }
}
