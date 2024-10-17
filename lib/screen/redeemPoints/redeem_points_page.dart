import 'package:flutter/material.dart';

class RedemptionItem {
  final String name;
  final int pointCost;
  RedemptionItem({required this.name, required this.pointCost});
}

class PointsRedemptionPage extends StatefulWidget {
  @override
  _PointsRedemptionPageState createState() => _PointsRedemptionPageState();
}

class _PointsRedemptionPageState extends State<PointsRedemptionPage> {
  int userPoints = 1000; // Example initial point balance

  List<RedemptionItem> items = [
    RedemptionItem(
      name: "Paid Leave (2 Days)",
      pointCost: 5000,
    ),
    RedemptionItem(
      name: "Paid Leave (1 Day)",
      pointCost: 3000,
    ),
    RedemptionItem(
      name: "Plane Ticket (2 Days)",
      pointCost: 3000,
    ),
    RedemptionItem(
      name: "Free Dental Check-up",
      pointCost: 1500,
    ),
    RedemptionItem(
      name: "Free Medical Check-up",
      pointCost: 1500,
    ),
    RedemptionItem(
      name: "Samsung A10",
      pointCost: 100,
    ),
    RedemptionItem(
      name: "Basic Needs (Food, Toiletries)",
      pointCost: 700,
    ),
    RedemptionItem(
      name: "Phone Recharge",
      pointCost: 500,
    ),
  ];

  void redeemItem(RedemptionItem item) {
    if (userPoints >= item.pointCost) {
      setState(() {
        userPoints -= item.pointCost;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Successfully redeemed ${item.name}!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough points to redeem ${item.name}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redeem Points'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Points:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$userPoints',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('${item.pointCost} points'),
                    trailing: ElevatedButton(
                      child: Text('Redeem'),
                      onPressed: () => redeemItem(item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: userPoints >= item.pointCost
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
