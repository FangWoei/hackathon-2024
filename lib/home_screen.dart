import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/screen/home_page.dart';
import 'package:hackthon_2024/screen/loginRegister/login.dart';
import 'package:hackthon_2024/services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 192, 255, 185),
          automaticallyImplyLeading: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hackathon",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
          centerTitle: true, // Ensure the title itself is centered
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await AuthService().signOut();
                context.pushNamed(Login.routeName);
              },
            ),
          ],
        ),
        body: const TabBarView(
            children: [HomePage()]),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 192, 255, 185),
          child: const TabBar(tabs: [
            Tab(
               text: "Home",
              icon: Icon(Icons.home),
            ),
            // Tab(text: "Ended", icon: Icon(Icons.delete_forever_outlined)),
            // Tab(text: "Post", icon: Icon(Icons.post_add_rounded)),
            // Tab(text: "BMI", icon: Icon(Icons.speed_sharp)),
          ]),
        ),
      ),
    );
  }
}
