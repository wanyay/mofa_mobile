import 'package:flutter/material.dart';
import 'package:mofa_mobile/screens/notary_detail.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotaryHistoryScreen extends StatelessWidget {
  const NotaryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF6A2C91);
    const Color backgroundColor = Color(0xFFE3DFFD);
    return Scaffold(
      appBar: AppBar(
        // The AppBar has the same background color and no shadow
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // Handle back button tap
            Navigator.of(context).pop();
          },
          child: const Row(
            children: [
              SizedBox(width: 8.0), // A little spacing
              Icon(Icons.arrow_back_ios, color: primaryTextColor, size: 20),
              Text(
                'Back',
                style: TextStyle(color: primaryTextColor, fontSize: 16),
              ),
            ],
          ),
        ),
        leadingWidth: 80, // Adjust width to fit the icon and text
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const TicketCard(
                title: 'တက္ကသိုလ်ဝင်တန်း အောင်လက်မှတ်',
                date: '၁၂-၅-၂၀၂၄',
                status: 'ထုတ်ယူပြီး',
                referenceNo: '52154789',
                qrData: '52154789',
                cardColor: Color(0xFF3B3251),
              ),
              const SizedBox(height: 16),
              // Second Ticket Card
              const TicketCard(
                title: 'xxxxx xxxxx xxxxx xx အောင်လက်မှတ်',
                date: '၁၆-၆-၂၀၂၄',
                status: 'ထုတ်ယူပြီး',
                referenceNo: '65897885',
                qrData: '65897885',
                cardColor: Color(0xFF3B3251),
              ),
              const SizedBox(height: 16),
              // Third Ticket Card
              const TicketCard(
                title: 'xxxx xxxx xxxx xxxxx အောင်လက်မှတ်',
                date: '၂၆.၆.၂၀၂၄',
                status: 'ဆောင်ရွက်ဆဲ',
                referenceNo: '54878885',
                qrData: '54878885',
                cardColor: Color(0xFF3949AB),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String referenceNo;
  final String qrData;
  final Color cardColor;

  const TicketCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.referenceNo,
    required this.qrData,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotaryDetail()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
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
                      _buildDetailRow('ရက်စွဲ', date),
                      const SizedBox(height: 8),
                      _buildDetailRow('Status', status),
                      const SizedBox(height: 8),
                      _buildDetailRow('Reference No.', referenceNo),
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
                    data: qrData,
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
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
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
