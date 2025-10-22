import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mofa_mobile/models/notary_history.dart';
import 'package:mofa_mobile/screens/notary_detail.dart';
import 'package:mofa_mobile/util/string_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotaryCard extends StatelessWidget {
  final NotaryHistory history;

  const NotaryCard({super.key, required this.history});

  Color getColor() {
    if (history.isHardCopied) {
      return Colors.green;
    }
    return Color(0xFF3949AB); // Default color
  }

  String getStatus() {
    if (history.isHardCopied) {
      return 'ထုတ်ယူပြီး';
    }
    return 'ဆောင်ရွက်နေဆဲ';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotaryDetail(history: history),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              history.notaryName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        'ရက်စွဲ',
                        StringHelper.convertToBurmese(
                          DateFormat('dd-MM-yyyy').format(history.createdAt),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow('Status', getStatus()),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        'Reference No.',
                        StringHelper.convertToBurmese(history.ticketID),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // QR Code Section
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: QrImageView(
                    data: history.ticketID,
                    version: QrVersions.auto,
                    size: 80.0,
                    gapless: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build each row of details
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100, // Fixed width for labels
          child: Text(
            label,
            style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
