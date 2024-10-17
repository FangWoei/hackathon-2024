import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/admin_screen/admin_home_page.dart';
import 'package:hackthon_2024/screen/loginRegister/login.dart';
import 'package:hackthon_2024/services/auth_services.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  static const routeName = "admin";

@override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
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
        body: const TabBarView(children: [
          AdminHomePage(),
        ]),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 192, 255, 185),
          child: const TabBar(
              splashBorderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
              tabs: [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
              ]),
        ),
      ),
    );
  }
}