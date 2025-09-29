import 'package:flutter/material.dart';
import 'package:mofa_mobile/screens/app_log.dart';
import 'package:mofa_mobile/screens/make_notary.dart';
import 'package:mofa_mobile/screens/notary_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40.0),
            const AppLogo(),
            const SizedBox(height: 24.0),
            _buildProfileCard(context),
            const SizedBox(height: 24.0),
            _buildNotaryHistory1(context),
            const SizedBox(height: 24.0),
            _buildNotaryHistory2(context),
            const SizedBox(height: 24.0),
            _buildNotaryHistory3(context),
          ],
        ),
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
            '09691216112',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Mg Kyaw Kyaw Naing',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            '၁၂/မမန(နိုင်)၀၁၀၂၅',
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

  Widget _buildNotaryHistory1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 53, 38, 65),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'တက္ကသိုလ်ဝင်တန်းအောင်လက်မှတ် လျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MakeNotary()),
              ),
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 138, 86, 172),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                const Text(
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
  }

  Widget _buildNotaryHistory2(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 178, 85, 252),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'xxx xxxx xxxx xxxx xxx လက်မှတ် လျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MakeNotary()),
              ),
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 113, 3, 175),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                const Text(
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
  }

  Widget _buildNotaryHistory3(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 57, 53, 172),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'xxx xxxx xxxx xxxx xxx လက်မှတ် လျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MakeNotary()),
              ),
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 68, 112, 255),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                const Text(
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
  }
}
