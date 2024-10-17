import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackthon_2024/home_screen.dart';
import 'package:hackthon_2024/admin_home_screen.dart';
import 'package:hackthon_2024/repo/user_repo.dart';
import 'package:hackthon_2024/screen/loginRegister/register.dart';
import 'package:hackthon_2024/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final UserRepo _userRepo = UserRepo();

  String? emailError;
  String? passwordError;
  String? loginError;
  bool isLoading = false;

  void _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    setState(() {
      emailError = email.isEmpty ? 'Please enter your email' : null;
      passwordError = password.isEmpty ? 'Please enter your password' : null;
      loginError = null;
      isLoading = true;
    });

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // First, authenticate the user
        await _authService.signInWithEmailAndPassword(email, password);
        
        // Then fetch the user data to check their role
        final user = await _userRepo.getUser();
        
        if (user != null) {
          // Route based on user role
          if (user.role == "admin") {
            if (mounted) {
              context.pushNamed(AdminHomeScreen.routeName);
            }
          } else {
            if (mounted) {
              context.pushNamed(HomeScreen.routeName);
            }
          }
        } else {
          setState(() {
            loginError = 'User data not found.';
          });
        }
      } catch (e) {
        setState(() {
          loginError = 'Login failed. Please check your email or password.';
        });
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _register() async {
    await context.pushNamed(Register.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 30.0),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: emailController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: "Email",
                        errorText: emailError,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: passwordError,
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 20.0),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[400],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                if (loginError != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      loginError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: SpinKitWave(
                  color: Colors.green,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}