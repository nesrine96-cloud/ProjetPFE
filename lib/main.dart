import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pacman/pages/login_page.dart';
import 'package:pacman/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'pages/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor('#D44CF6');
  Color _accentColor = HexColor('#5E18C8');
  @override
 Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges, initialData: null,
        ),
      ],
    child: MaterialApp(
      title: 'Navigation System',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
  debugShowCheckedModeBanner: false,
      home: SplashScreen(title: 'Navigation System'),
    ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if(user != null){
      return HomePage();
    }
    return LoginPage();
  }

}
