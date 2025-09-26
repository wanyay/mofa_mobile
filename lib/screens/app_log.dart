import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: const Color(0xFFF0E3A5),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: const Color(0xFF192A56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.security, size: 40, color: Color(0xFFF0E3A5)),
            SizedBox(height: 4),
            Text(
              'MOFA',
              style: TextStyle(
                color: Color(0xFFF0E3A5),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
