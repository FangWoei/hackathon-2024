import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackForm()),
            );
          },
          child: const Icon(Icons.mail)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Today's Performance",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        _HarvestingMetric(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const _WeeklyEarningsCard(),
                const SizedBox(height: 16),
                const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const _ActivityCard(
                  title: 'Harvesting',
                  completedValue: 3.8,
                  targetValue: 5,
                  unit: 'tonnes',
                  date: '17-10-2024',
                  extra: "0",
                  money: "RM190",
                ),
                const SizedBox(height: 16),
                const _ActivityCard(
                  title: 'Harvesting',
                  completedValue: 4,
                  targetValue: 4,
                  unit: 'tonnes',
                  date: '15-10-2024',
                  extra: "2",
                  money: "RM320 (100 points)",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeeklyEarningsCard extends StatelessWidget {
  const _WeeklyEarningsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Earnings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'RM160 / RM250',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 12),
            Text(
              '*Each extra tonne corresponds to RM60 and 50 points',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HarvestingMetric extends StatelessWidget {
  const _HarvestingMetric();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Harvesting',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '3.2 tonnes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 0.64,
            backgroundColor: Colors.grey[500],
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue[900] ?? Colors.blue,
            ),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Target: 5 tonnes',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Done: 64%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final double completedValue;
  final double targetValue;
  final String unit;
  final String date;
  final String extra;
  final String money;

  const _ActivityCard({
    required this.title,
    required this.completedValue,
    required this.targetValue,
    required this.unit,
    required this.date,
    required this.extra,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    final completionPercentage =
        (completedValue / targetValue * 100).toStringAsFixed(0);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            // Left side: Pie Chart
            SizedBox(
              width: 100,
              height: 100,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: completedValue,
                      title: '',
                      radius: 30,
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      value: targetValue - completedValue,
                      title: '',
                      radius: 30,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 25,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right side: Title and Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: $date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Target: $targetValue $unit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Completed: $completionPercentage%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '($completedValue $unit)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Extra: $extra $unit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "Total: $money",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String? selectedReason; // To store the selected feedback reason
  final List<String> feedbackReasons = [
    "Report bug",
    "Report health issue",
    "Report supervisor issue",
    "Report accommodation issue",
    "General feedback",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Feedback Reason:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: feedbackReasons.map((reason) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedReason = reason;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedReason == reason
                        ? Colors.blue
                        : Colors.grey[300], // Change color when selected
                  ),
                  child: Text(reason),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedReason != null) {
                  // Handle feedback submission
                  Navigator.pop(context);
                } else {
                  // Show a warning if no reason is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a feedback reason.'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
