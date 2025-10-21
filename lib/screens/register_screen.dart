// Make sure you have the collection package in pubspec.yaml
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mm_nrc/mm_nrc.dart';
import 'package:mofa_mobile/providers/auth_provider.dart';
import 'package:mofa_mobile/screens/app_log.dart';
import 'package:mofa_mobile/screens/home_screen.dart';
import 'package:mofa_mobile/util/auth_manager.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _selectedNrcState;
  String? _selectedNrcTownship;
  String? _selectedNrcType;

  // These lists will hold the data for the UI
  List<String> nrcStates = [];
  List<String> nrcTownships = [];
  List<String> nrcTypes = [];

  // These lists will hold the full data from the package
  List<StateDivision> _fullStatesList = [];
  List<Township> _fullTownshipsList = [];
  List<Types> _fullTypesList = [];

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _nrcNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
    _loadNrcData();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _nrcNumberController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadNrcData() async {
    // Fetch all data first
    _fullStatesList = (await MmNrc.states())
        .whereType<StateDivision>()
        .toList();
    _fullTownshipsList = await MmNrc.townships();
    _fullTypesList = await MmNrc.types();

    // Prepare the lists for the dropdowns
    nrcStates = _fullStatesList.map((e) => e.number.mm).toList();
    nrcTypes = _fullTypesList.map((e) => e.name.mm).toList();

    // Set the initial state and load its townships
    if (nrcStates.isNotEmpty) {
      setState(() {
        _selectedNrcState = _fullStatesList.first.number.mm;
        // Directly update townships for the first state
        _updateTownshipListForState(_selectedNrcState);
      });
    }
  }

  void _checkAuthentication() {
    final authKey = AuthManager.readAuth();
    if (authKey.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _updateTownshipListForState(String? stateNumberMm) {
    if (stateNumberMm == null) {
      nrcTownships = [];
      _selectedNrcTownship = null;
      return;
    }

    // Find the selected state object to get its code (e.g., "1", "2")
    final selectedState = _fullStatesList.firstWhereOrNull(
      (s) => s.number.mm == stateNumberMm,
    );

    if (selectedState != null) {
      // Filter the FULL township list based on the selected state's code
      nrcTownships = _fullTownshipsList
          .where((township) => township.stateCode == selectedState.number.en)
          .map((township) => township.short.mm)
          .toList();
    } else {
      nrcTownships = [];
    }
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
            child: Consumer<AuthNotifier>(
              builder: (context, authProvider, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (authProvider.status == AuthStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'မှတ်ပုံတင်ခြင်း အောင်မြင်ပါသည်။ လော့ဂ်အင် ပြန်လည်ဝင်ရောက်ပါ။',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    authProvider.resetStatus();

                    Future.delayed(const Duration(seconds: 1), () {
                      if (mounted) {
                        // Check if the widget is still in the tree
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    });
                  } else if (authProvider.status == AuthStatus.failure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(authProvider.error)));
                  }
                });
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Your existing widgets (Logo, Titles, etc.) go here...
                    const AppLogo(),
                    const SizedBox(height: 24.0),
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
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF5A4D7B),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
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
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'အသုံးပြုသူအမည်',
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // NRC Input Row
                    Row(
                      children: [
                        // State Dropdown
                        _buildNrcDropdown(
                          nrcStates,
                          (newValue) {
                            // --- FIX 2: Corrected onChanged Logic ---
                            if (newValue == null) return;
                            setState(() {
                              _selectedNrcState = newValue;
                              // When the state changes, update the township list
                              _updateTownshipListForState(newValue);
                            });
                          },
                          _selectedNrcState,
                          0.2,
                        ),
                        const SizedBox(width: 8),
                        // Township Dropdown
                        _buildNrcDropdown(
                          nrcTownships,
                          (newValue) {
                            setState(() {
                              _selectedNrcTownship = newValue;
                            });
                          },
                          _selectedNrcTownship,
                          0.25, // Adjusted width slightly
                        ),
                        const SizedBox(width: 8),
                        // Type Dropdown
                        _buildNrcDropdown(
                          nrcTypes,
                          (newValue) {
                            setState(() {
                              _selectedNrcType = newValue;
                            });
                          },
                          _selectedNrcType,
                          0.2,
                        ),
                        const SizedBox(width: 8),
                        // Number Input
                        Expanded(
                          child: TextFormField(
                            controller: _nrcNumberController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '၁၂၃၄၅၆',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Your other widgets (Passwords, Button, etc.) go here...
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      controller: _retypePasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Retype Password',
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        if (authProvider.status == AuthStatus.loading) {
                          return; // Prevent multiple submissions
                        }
                        final fullNrc =
                            '$_selectedNrcState/$_selectedNrcTownship($_selectedNrcType)${_nrcNumberController.text}';
                        authProvider.register(
                          _nameController.text,
                          _phoneController.text,
                          fullNrc,
                          _passwordController.text,
                          _retypePasswordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4727A0),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        authProvider.status == AuthStatus.loading
                            ? 'လုပ်ဆောင်နေသည်'
                            : 'အကောင့်အသစ်ပြုလုပ်မည်',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
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
    final dropdownValue = value != null && items.contains(value) ? value : null;

    return Container(
      width:
          (MediaQuery.of(context).size.width - 64) *
          widthFactor, // Adjusted width calculation
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Center(
            child: Text("-", style: TextStyle(fontSize: 14)),
          ), // Hint for when value is null
          value: dropdownValue,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Center(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
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
