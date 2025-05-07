class Notification {
  final int? id;
  final String? title;
  final String? content;
  final bool? isRead;
  final String? createdAt;
  final int? status;

  const Notification({
    this.id,
    this.title,
    this.content,
    this.isRead,
    this.createdAt,
    this.status,
  });
}
