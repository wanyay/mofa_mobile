import 'package:flutter/material.dart';
import 'package:mofa_mobile/providers/auth_provider.dart';
import 'package:mofa_mobile/screens/app_log.dart';
import 'package:mofa_mobile/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Consumer<AuthNotifier>(
              builder: (context, authProvider, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (authProvider.status == AuthStatus.success) {
                    Navigator.pushReplacementNamed(context, '/home');
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
                    // Logo Placeholder
                    const AppLogo(),
                    const SizedBox(height: 24.0),

                    // Title
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF321B6B),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'သင့်အကောင့်သို့ ပြန်လည်ဝင်ရောက်ရန်',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF5A4D7B),
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    // Phone Number Input
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

                    // Password Input
                    TextFormField(
                      obscureText: _isPasswordObscured,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (authProvider.status == AuthStatus.loading) {
                          return; // Prevent multiple submissions
                        }
                        authProvider.login(
                          _phoneController.text,
                          _passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4727A0),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'လော့ဂ်အင်ဝင်မည်',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Navigate to Registration Screen
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "အကောင့်မရှိသေးဘူးလား? အကောင့်အသစ်ပြုလုပ်ရန်",
                        style: TextStyle(
                          color: Color(0xFF4727A0),
                          fontWeight: FontWeight.bold,
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
}
