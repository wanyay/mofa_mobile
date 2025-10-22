import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/pricing.dart';
import 'package:mofa_mobile/models/township.dart';
import 'package:mofa_mobile/models/university.dart';
import 'package:mofa_mobile/providers/township_provider.dart';
import 'package:mofa_mobile/providers/university_provider.dart';
import 'package:mofa_mobile/screens/payment_screen.dart';
import 'package:mofa_mobile/screens/widgets/dropdown_row.dart';
import 'package:mofa_mobile/screens/widgets/info_row.dart';
import 'package:mofa_mobile/screens/widgets/input_text_row.dart';
import 'package:provider/provider.dart';

class BachelorCertificateForm extends StatefulWidget {
  final Pricing pricing;
  const BachelorCertificateForm({super.key, required this.pricing});

  @override
  State<BachelorCertificateForm> createState() =>
      _BachelorCertificateFormState();
}

class _BachelorCertificateFormState extends State<BachelorCertificateForm> {
  final _rollNoController = TextEditingController();
  final _yearController = TextEditingController();
  final _degreeController = TextEditingController();
  University? selectedPassUniversity;
  Township? selectedGetTownship;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final townshipProvider = Provider.of<TownshipProvider>(
      context,
      listen: false,
    );
    await townshipProvider.fetchTownships();

    final universityProvider = Provider.of<UniversityProvider>(
      // ignore: use_build_context_synchronously
      context,
      listen: false,
    );
    await universityProvider.fetchUniversities();
  }

  @override
  void dispose() {
    _rollNoController.dispose();
    _yearController.dispose();
    _degreeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Pricing pricing = widget.pricing;
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
        child: Consumer2<TownshipProvider, UniversityProvider>(
          builder: (context, townshipProvider, universityProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (townshipProvider.status == TownshipStatus.loading ||
                  universityProvider.status == UniversityStatus.loading) {
                Center(child: CircularProgressIndicator());
              } else if (townshipProvider.status == TownshipStatus.failure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(townshipProvider.error)));
              } else if (universityProvider.status ==
                  UniversityStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(universityProvider.error)),
                );
              }
            });
            return SingleChildScrollView(
              child: Column(
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
                          color: Colors.grey.withAlpha(26),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InputTextRow(
                          label: 'ခုံနံပါတ်',
                          hintText: 'ခုံနံပါတ် ထည့်ပါ',
                          controller: _rollNoController,
                        ),
                        InputTextRow(
                          label: 'ခုနှစ်',
                          hintText: 'ခုနှစ် ထည့်ပါ',
                          controller: _yearController,
                          keyboardType: TextInputType.number,
                        ),
                        InputTextRow(
                          label: 'ဘွဲ့ အမည်',
                          hintText: 'ဘွဲ့ အမည် ထည့်ပါ',
                          controller: _degreeController,
                        ),
                        DropdownRow<University>(
                          label: 'အောင်မြင်သည့် တက္ကသိုလ်',
                          hintText: 'တက္ကသိုလ်အားရွေးချယ်ပါ',
                          items: universityProvider.universities.toList(),
                          selectedValue: selectedPassUniversity,
                          onChanged: (University? university) {
                            setState(() {
                              selectedPassUniversity = university;
                            });
                          },
                          getLabel: (University university) => university.name,
                        ),
                        DropdownRow<Township>(
                          label: 'ထုတ်ယူမည့် မြို့နယ်',
                          hintText: 'မြို့နယ်အားရွေးချယ်ပါ',
                          items: townshipProvider.townships.toList(),
                          selectedValue: selectedGetTownship,
                          onChanged: (Township? township) {
                            setState(() {
                              selectedGetTownship = township;
                            });
                          },
                          getLabel: (Township township) => township.name,
                        ),
                        InfoRow(
                          label: 'ကျသင့်ငွေ',
                          value: ' ${pricing.price} ကျပ်',
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
                        final Map<String, dynamic> data = {
                          "rollNo": _rollNoController.text,
                          "year": _yearController.text,
                          "degree": _degreeController.text,
                          "passUniversity": selectedPassUniversity,
                          "getTownship": selectedGetTownship,
                          "pricing": pricing,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(formData: data),
                          ),
                        );
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
            );
          },
        ),
      ),
    );
  }
}
