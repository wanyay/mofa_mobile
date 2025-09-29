import 'package:flutter/material.dart';

class MakeNotary extends StatelessWidget {
  const MakeNotary({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF6A2C91);
    const Color backgroundColor = Color(0xFFE3DFFD);
    const Color primaryPurple = Color(0xFF8E44AD);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            // The main details card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  InfoRow(label: 'Phone No:', value: '09691216112'),
                  InfoRow(label: 'Name:', value: 'Mg Kyaw Kyaw Naing'),
                  InfoRow(label: 'NRC No:', value: '၁၂/မမန(နိုင်)၁၁၁၁၂၅'),
                  InfoRow(
                    label: 'ကျသင့်ငွေ:',
                    value: '၅၀၀၀ ကျပ်',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // The confirmation button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button tap action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'လျှောက်ထားမည်',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        // Add a divider unless it's the last item
        if (!isLast) Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }
}
