import 'package:flutter/material.dart';

class NotrayHistoryScreen extends StatelessWidget {
  const NotrayHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('လျှောက်ထားခဲ့သည့် Notray များ')),
      body: const Center(child: Text('Notray History')),
    );
  }
}
