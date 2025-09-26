import 'package:flutter/material.dart';
import 'package:mofa_mobile/screens/app_log.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Dummy data for the dropdowns
  final List<String> _nrcStates = [
    '1/',
    '2/',
    '3/',
    '4/',
    '5/',
    '6/',
    '7/',
    '8/',
    '9/',
    '10/',
    '11/',
    '12/',
    '13/',
    '14/',
  ];
  final List<String> _nrcTownships = ['မမန', 'ကမတ', 'လမန', 'ဗဟန', 'စခန'];
  final List<String> _nrcTypes = ['(နိုင်)', '(ဧည့်)', '(ပြု)'];

  String? _selectedNrcState;
  String? _selectedNrcTownship;
  String? _selectedNrcType;

  @override
  void initState() {
    super.initState();
    _selectedNrcState = _nrcStates[0];
    _selectedNrcTownship = _nrcTownships[0];
    _selectedNrcType = _nrcTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF321B6B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Placeholder
                const AppLogo(),
                const SizedBox(height: 24.0),

                // Title
                const Text(
                  'Registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF321B6B),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'အသုံးပြုသူ အကောင့်အသစ်ပြုလုပ်ခြင်း',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Color(0xFF5A4D7B)),
                ),
                const SizedBox(height: 32.0),

                // Phone Number Input
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '+959',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.grey),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    hintText: 'Mobile Number',
                  ),
                ),
                const SizedBox(height: 16.0),

                // Name Input
                TextFormField(
                  decoration: const InputDecoration(hintText: 'အသုံးပြုသူအမည်'),
                ),
                const SizedBox(height: 16.0),

                // NRC Input Row
                Row(
                  children: [
                    _buildNrcDropdown(
                      _nrcStates,
                      (val) {
                        setState(() => _selectedNrcState = val);
                      },
                      _selectedNrcState,
                      0.2,
                    ), // 20% width
                    const SizedBox(width: 8),
                    _buildNrcDropdown(
                      _nrcTownships,
                      (val) {
                        setState(() => _selectedNrcTownship = val);
                      },
                      _selectedNrcTownship,
                      0.2,
                    ), // 20% width
                    const SizedBox(width: 8),
                    _buildNrcDropdown(
                      _nrcTypes,
                      (val) {
                        setState(() => _selectedNrcType = val);
                      },
                      _selectedNrcType,
                      0.2,
                    ), // 20% width
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: '၁၂၃၄၅၆'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Password Input
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 16.0),

                // Retype Password Input
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Retype Password',
                  ),
                ),
                const SizedBox(height: 32.0),

                // Registration Button
                ElevatedButton(
                  onPressed: () {
                    // Handle registration logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4727A0),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'အကောင့်အသစ်ပြုလုပ်မည်',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNrcDropdown(
    List<String> items,
    ValueChanged<String?> onChanged,
    String? value,
    double widthFactor,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * widthFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(value, style: const TextStyle(fontSize: 14)),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
