import 'package:flutter/material.dart';
import 'package:mofa_mobile/models/pricing.dart';
import 'package:mofa_mobile/providers/pricing_provider.dart';
import 'package:mofa_mobile/screens/app_log.dart';
import 'package:mofa_mobile/screens/bachelor_certificate_form.dart';
import 'package:mofa_mobile/screens/matrix_mark_form.dart';
import 'package:mofa_mobile/screens/matrix_pass_form.dart';
import 'package:mofa_mobile/screens/notary_history_screen.dart';
import 'package:mofa_mobile/util/auth_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String phone = AuthManager.getPhone();
  final String name = AuthManager.getName();
  final String nrc = AuthManager.getNRC();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!AuthManager.isLogin()) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        _loadNotaryPricings();
      }
    });
  }

  Future<void> _loadNotaryPricings() async {
    final pricingProvider = Provider.of<PricingProvider>(
      context,
      listen: false,
    );
    await pricingProvider.fetchPricings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PricingProvider>(
        builder: (context, pricingProvider, child) {
          if (pricingProvider.status == PricingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (pricingProvider.status == PricingStatus.failure) {
            return Center(
              child: Text(
                'Error: ${pricingProvider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40.0),
                const AppLogo(),
                const SizedBox(height: 24.0),
                _buildProfileCard(context),
                const SizedBox(height: 20.0),
                _buildNotaryCard(context, pricingProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phone,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            nrc,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotaryHistoryScreen(),
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4727A0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'လျှောက်ထားခဲ့သည့် Notary များ',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotaryCard(
    BuildContext context,
    PricingProvider pricingProvider,
  ) {
    return Column(
      children: pricingProvider.pricings.map((pricing) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: _getBackgroundColor(pricing),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pricing.name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        switch (pricing.notaryID) {
                          case 1:
                            return MatrixMarkForm(pricing: pricing);
                          case 2:
                            return MatrixPassForm(pricing: pricing);
                          case 3:
                            return BachelorCertificateForm(pricing: pricing);
                          default:
                            return BachelorCertificateForm(pricing: pricing);
                        }
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonBackgroundColor(pricing),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Row(
                  children: [
                    Text(
                      'လျှောက်မည်',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getBackgroundColor(Pricing notaryPricing) {
    switch (notaryPricing.notaryID) {
      case 1:
        return Color.fromARGB(255, 53, 38, 65);
      case 2:
        return Color.fromARGB(255, 178, 85, 252);
      default:
        return Color.fromARGB(255, 57, 53, 172);
    }
  }

  Color _getButtonBackgroundColor(Pricing notaryPricing) {
    switch (notaryPricing.notaryID) {
      case 1:
        return Color.fromARGB(255, 138, 86, 172);
      case 2:
        return Color.fromARGB(255, 113, 3, 175);
      default:
        return Color.fromARGB(255, 68, 112, 255);
    }
  }
}
