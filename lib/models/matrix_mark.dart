import 'package:mofa_mobile/models/township.dart';

class MatrixMark {
  int id;
  int loginID;
  String ticketID;
  String rollNo;
  String year;
  Township passTownship;
  Township getTownship;
  String school;
  bool? isApproved;
  bool isPaid;
  bool isHardCopied;

  MatrixMark({
    required this.id,
    required this.loginID,
    required this.ticketID,
    required this.rollNo,
    required this.year,
    required this.passTownship,
    required this.getTownship,
    required this.school,
    required this.isApproved,
    required this.isPaid,
    required this.isHardCopied,
  });

  factory MatrixMark.fromJson(Map<String, dynamic> json) {
    return MatrixMark(
      id: json['id'] as int,
      loginID: json['loginID'] as int,
      ticketID: json['ticketID'] as String,
      rollNo: json['rollNo'] as String,
      year: json['year'] as String,
      passTownship: Township.fromJson(json['passTownship']),
      getTownship: Township.fromJson(json['getTownship']),
      school: json['school'] as String,
      isApproved: json['isApproved'] as bool?,
      isPaid: json['isPaid'] as bool,
      isHardCopied: json['isHardCopied'] as bool,
    );
  }
}
