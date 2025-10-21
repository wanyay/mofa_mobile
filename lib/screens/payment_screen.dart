import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/pricing.dart';
import 'package:mofa_mobile/models/township.dart';
import 'package:mofa_mobile/models/university.dart';
import 'package:mofa_mobile/providers/notary_provider.dart';
import 'package:mofa_mobile/screens/widgets/info_row.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> formData;

  const PaymentScreen({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF6A2C91);
    const Color backgroundColor = Color(0xFFE3DFFD);
    const Color primaryPurple = Color(0xFF8E44AD);
    final String rollNo = formData['rollNo'];
    final String year = formData['year'];
    final String? school = formData['school'];
    final String? degree = formData['degree'];
    final Township? passTownship = formData['passTownship'];
    final Township? getTownship = formData['getTownship'];
    final University? passUniversity = formData['passUniversity'];
    final Pricing pricing = formData['pricing'];

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
        child: Consumer<NotaryProvider>(
          builder: (context, notaryProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (notaryProvider.status == NotaryStatus.failure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(notaryProvider.error)));
              }
            });
            return Column(
              children: [
                Text(
                  pricing.name,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
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
                  child: Column(
                    children: [
                      InfoRow(label: 'ခုံနံပါတ်', value: rollNo),
                      InfoRow(label: 'ခုနှစ်', value: year),

                      pricing.notaryID == 3
                          ? InfoRow(label: 'ဘွဲ့ အမည်', value: degree)
                          : InfoRow(label: 'ကျောင်းအမည်', value: school),
                      pricing.notaryID == 3
                          ? InfoRow(
                              label: 'အောင်မြင်သည့် တက္ကသိုလ်',
                              value: passUniversity?.name ?? '',
                            )
                          : InfoRow(
                              label: 'အောင်မြင်သည့် မြို့နယ်',
                              value: passTownship?.name ?? '',
                            ),
                      InfoRow(
                        label: 'ထုတ်ယူသည့် မြို့နယ်',
                        value: getTownship?.name ?? '',
                      ),
                      InfoRow(
                        label: 'ကျသင့်ငွေ',
                        value: '${pricing.price} ကျပ်',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // The confirmation button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: notaryProvider.status == NotaryStatus.loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.login, color: Colors.white),
                    onPressed: () async {
                      if (notaryProvider.status == NotaryStatus.loading) {
                        return; // Prevent multiple submissions
                      }
                      switch (pricing.notaryID) {
                        case 1:
                          await Provider.of<NotaryProvider>(
                            context,
                            listen: false,
                          ).createMatrixMarkNotary(
                            rollNo,
                            year,
                            school,
                            passTownship?.id,
                            getTownship?.id,
                          );
                        case 2:
                          await Provider.of<NotaryProvider>(
                            context,
                            listen: false,
                          ).createMatrixPassNotary(
                            rollNo,
                            year,
                            school,
                            passTownship?.id,
                            getTownship?.id,
                          );
                        case 3:
                          await Provider.of<NotaryProvider>(
                            context,
                            listen: false,
                          ).createBachelorCertificateNotary(
                            rollNo,
                            year,
                            degree,
                            passUniversity?.id,
                            getTownship?.id,
                          );
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Unknown notary type.")),
                          );
                      }
                      if (notaryProvider.status == NotaryStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('လျှောက်ထားမှု အောင်မြင်ပါသည်။'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        notaryProvider.resetAll();
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    label: Text(
                      notaryProvider.status == NotaryStatus.loading
                          ? 'ငွေပေးချေးမူ လုပ်ဆောင်နေသည်...'
                          : 'ငွေပေးချေးမည်',
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
            );
          },
        ),
      ),
    );
  }
}
