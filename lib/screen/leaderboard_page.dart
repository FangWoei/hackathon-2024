import 'package:flutter/material.dart';

class LeaderboardEntry {
  final String name;
  final int score;
  final String avatarUrl;

  LeaderboardEntry(
      {required this.name, required this.score, required this.avatarUrl});
}

class LeaderboardScreen extends StatelessWidget {
  final List<LeaderboardEntry> entries = [
    LeaderboardEntry(
        name: "John Doe",
        score: 1000,
        avatarUrl: "https://example.com/avatar1.jpg"),
    LeaderboardEntry(
        name: "Jane Smith",
        score: 850,
        avatarUrl: "https://example.com/avatar2.jpg"),
    LeaderboardEntry(
        name: "Bob Johnson",
        score: 720,
        avatarUrl: "https://example.com/avatar3.jpg"),
    // Add more entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFCBD5E0), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Leaderboard",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: LeaderboardTile(
                      entry: entries[index],
                      rank: index + 1,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;

  const LeaderboardTile({Key? key, required this.entry, required this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCBD5E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              '#$rank',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C5282),
              ),
            ),
            SizedBox(width: 16),
            CircleAvatar(
              backgroundImage: NetworkImage(entry.avatarUrl),
              radius: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Score: ${entry.score}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
