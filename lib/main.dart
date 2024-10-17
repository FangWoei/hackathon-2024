import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/admin_home_screen.dart';
import 'package:hackthon_2024/firebase_options.dart';
import 'package:hackthon_2024/home_screen.dart';
import 'package:hackthon_2024/repo/user_repo.dart';
import 'package:hackthon_2024/screen/loginRegister/login.dart';
import 'package:hackthon_2024/screen/loginRegister/register.dart';
import 'package:hackthon_2024/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hackathon',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          name: Login.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const Login();
          },
        ),
        GoRoute(
          path: 'register',
          name: Register.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const Register();
          },
        ),
        GoRoute(
          path: 'home',
          name: HomeScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: 'admin',
          name: AdminHomeScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const AdminHomeScreen();
          },
        ),
      ],
    ),
  ],
);

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // User is logged in, now check their role
          return FutureBuilder(
            future: UserRepo().getUser(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                // Show loading spinner while fetching user data
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (userSnapshot.hasError) {
                // Handle error state
                return const Scaffold(
                  body: Center(
                    child: Text('Error loading user data'),
                  ),
                );
              }

              final user = userSnapshot.data;
              if (user != null) {
                // Route based on user role
                if (user.role == 'admin') {
                  return const AdminHomeScreen();
                } else {
                  return const HomeScreen();
                }
              }

              // If we couldn't get user data, redirect to login
              return const Login();
            },
          );
        } else {
          // User is not logged in
          return const Login();
        }
      },
    );
  }
}
