import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/screen/home_page.dart';
import 'package:hackthon_2024/screen/leaderboard_page.dart';
import 'package:hackthon_2024/screen/loginRegister/login.dart';
import 'package:hackthon_2024/screen/redeemPoints/redeem_points_page.dart';
import 'package:hackthon_2024/services/auth_services.dart';
import 'package:hackthon_2024/screen/leaderboard/leaderboard_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
        body: TabBarView(children: [
          const HomePage(),
          LeaderboardScreen(),
          PointsRedemptionPage()
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
                Tab(text: "Leaderboard", icon: Icon(Icons.leaderboard)),
                Tab(text: "Points", icon: Icon(Icons.redeem)),
                // Tab(text: "BMI", icon: Icon(Icons.speed_sharp)),
              ]),
        ),
      ),
    );
  }
}
