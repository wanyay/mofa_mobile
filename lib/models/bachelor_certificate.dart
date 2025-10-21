import 'package:mofa_mobile/models/township.dart';
import 'package:mofa_mobile/models/university.dart';

class BachelorCertificate {
  int id;
  int loginID;
  String ticketID;
  String rollNo;
  String year;
  University passUniversity;
  Township getTownship;
  String degree;
  bool? isApproved;
  bool isPaid;
  bool isHardCopied;

  BachelorCertificate({
    required this.id,
    required this.loginID,
    required this.ticketID,
    required this.rollNo,
    required this.year,
    required this.passUniversity,
    required this.getTownship,
    required this.degree,
    required this.isApproved,
    required this.isPaid,
    required this.isHardCopied,
  });

  factory BachelorCertificate.fromJson(Map<String, dynamic> json) {
    return BachelorCertificate(
      id: json['id'] as int,
      loginID: json['loginID'] as int,
      ticketID: json['ticketID'] as String,
      rollNo: json['rollNo'] as String,
      year: json['year'] as String,
      passUniversity: University.fromJson(json['passUniversity']),
      getTownship: Township.fromJson(json['getTownship']),
      degree: json['degree'] as String,
      isApproved: json['isApproved'] as bool?,
      isPaid: json['isPaid'] as bool,
      isHardCopied: json['isHardCopied'] as bool,
    );
  }
}
