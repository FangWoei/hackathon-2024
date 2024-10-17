import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackthon_2024/screen/event/event_page.dart';
import 'package:hackthon_2024/screen/home_page.dart';
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Colors.grey[900],
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hackathon",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400]),
              )
            ],
          ),
          centerTitle: true, // Ensure the title itself is centered
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.grey[400],
              ),
              onPressed: () async {
                await AuthService().signOut();
                context.pushNamed(Login.routeName);
              },
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.translate,
                  color: Colors.grey[400],
                ))
          ],
        ),
        body: TabBarView(children: [
          const HomePage(),
          TeamPage(),
          LeaderboardScreen(),
          PointsRedemptionPage(),
        ]),
        bottomNavigationBar: Container(
          color: Colors.grey[900],
          child: TabBar(
              splashBorderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
              labelColor: Colors.grey[400],
              indicatorColor: Colors.grey[400],
              tabs: const [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(text: "Team", icon: Icon(Icons.people)),
                Tab(text: "Leaderboard", icon: Icon(Icons.leaderboard)),
                Tab(text: "Points", icon: Icon(Icons.redeem)),
              ]),
        ),
      ),
    );
  }
}
