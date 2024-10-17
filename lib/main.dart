import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // display(name: "name", email: "name@gmail.com");
}

// This widget is the root of your application
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final routes = [
    GoRoute(
      path: "/",
      name: HomeScreen.routeName,
      builder: (_, __) => const HomeScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(initialLocation: "/", routes: routes),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum Screen { home }
