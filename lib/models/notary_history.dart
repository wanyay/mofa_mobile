class NotaryHistory {
  final String ticketID;
  final bool? isApproved;
  final bool isPaid;
  final bool isHardCopied;
  final DateTime createdAt;
  final String notaryName;
  final int notaryID;

  NotaryHistory({
    required this.ticketID,
    required this.isApproved,
    required this.isPaid,
    required this.isHardCopied,
    required this.createdAt,
    required this.notaryName,
    required this.notaryID,
  });

  factory NotaryHistory.fromJson(Map<String, dynamic> json) {
    return NotaryHistory(
      ticketID: json['ticketID'] as String,
      isApproved: json['isApproved'] as bool?,
      isPaid: json['isPaid'] as bool,
      isHardCopied: json['isHardCopied'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      notaryName: json['notaryName'] as String,
      notaryID: json['notaryID'] as int,
    );
  }
}
