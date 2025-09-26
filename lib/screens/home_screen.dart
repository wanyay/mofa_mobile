import 'package:flutter/material.dart';
import 'package:mofa_mobile/screens/app_log.dart';
import 'package:mofa_mobile/screens/notray_history_screen.dart';

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
            const AppLogo(),
            const SizedBox(height: 24.0),
            _buildProfileCard(context),
            const SizedBox(height: 24.0),
            _buildNotrayHistory1(),
            const SizedBox(height: 24.0),
            _buildNotrayHistory2(),
            const SizedBox(height: 24.0),
            _buildNotrayHistory3(),
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
                      builder: (context) => NotrayHistoryScreen(),
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4727A0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 50.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'လျှောက်ထားခဲ့သည့် Notray များ',
                  style: TextStyle(
                    fontSize: 18.0,
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

  Widget _buildNotrayHistory1() {
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'တက္ကသိုလ်ဝင်တန်း အောင်လက်မှတ်\nလျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => const {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 138, 86, 172),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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

  Widget _buildNotrayHistory2() {
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'xxx xxxx xxxx xxxx xxx xxလက်မှတ်\nလျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => const {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 113, 3, 175),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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

  Widget _buildNotrayHistory3() {
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: [
          const SizedBox(width: 25),
          Expanded(
            child: const Text(
              'xxx xxxx xxxx xxxx xxx xxလက်မှတ်\nလျှောက်ထားခြင်း',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () => const {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 68, 112, 255),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
