import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotaryDetail extends StatelessWidget {
  const NotaryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF6A2C91);
    const Color backgroundColor = Color(0xFFE3DFFD);
    const Color secondaryTextColor = Colors.black87;
    const Color labelColor = Colors.black54;
    return Scaffold(
      backgroundColor: backgroundColor,
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
        // Use SingleChildScrollView to prevent overflow on smaller screens
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Title Text ---
              const Text(
                'တက္ကသိုလ်ဝင်တန်း အောင်လက်မှတ်\nလျှောက်ထားခြင်း',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.5, // Line height
                ),
              ),
              const SizedBox(height: 32),

              // --- QR Code ---
              // This uses the qr_flutter package.
              // Add `qr_flutter: ^4.1.0` to your pubspec.yaml
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: QrImageView(
                  data:
                      'Phone No: 09691216112\nName: Mg Kyaw Kyaw Naing\nNRC No: ၁၂/မမန(နိုင်)၀၀၀၀၂၅\nReference No: 54878885',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 32),

              // --- Information Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.08),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A reusable widget for each information row
                    _buildInfoRow(
                      'Phone No:',
                      '09691216112',
                      labelColor,
                      secondaryTextColor,
                    ),
                    const Divider(height: 30),
                    _buildInfoRow(
                      'Name:',
                      'Mg Kyaw Kyaw Naing',
                      labelColor,
                      secondaryTextColor,
                    ),
                    const Divider(height: 30),
                    _buildInfoRow(
                      'NRC No:',
                      '၁၂/မမန(နိုင်)၀၀၀၀၂၅',
                      labelColor,
                      secondaryTextColor,
                    ),
                    const Divider(height: 30),
                    _buildInfoRow(
                      'Reference No:',
                      '54878885',
                      labelColor,
                      secondaryTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    Color labelColor,
    Color valueColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 16)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
