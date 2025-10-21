import 'package:flutter/material.dart';
import 'package:mofa_mobile/getit/getit.dart';
import 'package:mofa_mobile/providers/notary_provider.dart';
import 'package:mofa_mobile/providers/university_provider.dart';
import 'package:mofa_mobile/repositories/notary_repository.dart';
import 'package:mofa_mobile/repositories/university_repository.dart';
import 'package:mofa_mobile/util/dio.dart';
import 'package:mofa_mobile/providers/auth_provider.dart';
import 'package:mofa_mobile/providers/pricing_provider.dart';
import 'package:mofa_mobile/providers/township_provider.dart';
import 'package:mofa_mobile/repositories/auth_repository.dart';
import 'package:mofa_mobile/repositories/pricing_repository.dart';
import 'package:mofa_mobile/repositories/township_repository.dart';
import 'package:mofa_mobile/screens/home_screen.dart';
import 'package:mofa_mobile/screens/login_screen.dart';
import 'package:mofa_mobile/util/auth_manager.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  DioProvider.initialize(navigatorKey);
  await getItInit();
  final initialRoute = AuthManager.readAuth().isNotEmpty ? '/home' : '/login';
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(AuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => TownshipProvider(TownshipRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => PricingProvider(PricingRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => NotaryProvider(NotaryRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => UniversityProvider(UniversityRepository()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'MOFA Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFE3DFFD),
          fontFamily: 'Pyidaungsu',
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
        ),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
