import 'package:flutter/material.dart';
import 'package:mofa_mobile/providers/notary_provider.dart';
import 'package:mofa_mobile/screens/widgets/notary_card.dart';
import 'package:provider/provider.dart';

class NotaryHistoryScreen extends StatefulWidget {
  const NotaryHistoryScreen({super.key});

  @override
  State<NotaryHistoryScreen> createState() => _NotaryHistoryScreenState();
}

class _NotaryHistoryScreenState extends State<NotaryHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotaryHistory();
    });
  }

  Future<void> _loadNotaryHistory() async {
    final notaryProvider = Provider.of<NotaryProvider>(context, listen: false);
    await notaryProvider.getNotaryHistory();
  }

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
      body: Consumer<NotaryProvider>(
        builder: (context, notaryProvider, child) {
          if (notaryProvider.status == NotaryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (notaryProvider.status == NotaryStatus.failure) {
            return Center(
              child: Text(
                'Error: ${notaryProvider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (notaryProvider.notaryHistory.isEmpty) {
            return const Center(
              child: Text(
                'လျောက်ထားသည့် မှတ်တမ်း မရှိပါ',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notaryProvider.notaryHistory.map((history) {
                  return NotaryCard(history: history);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
