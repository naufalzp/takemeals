import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:takemeals/screens/home_screen.dart';
import 'package:takemeals/screens/login_screen.dart';
import 'package:takemeals/theme/theme_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeHelper().changeTheme('primary');
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takemeals',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  final secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    var token = await secureStorage.read(key: "token");
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? HomeScreen() : LoginScreen();
  }
}
