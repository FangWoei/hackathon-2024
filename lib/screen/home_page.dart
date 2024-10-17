import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int personCount = 0;
  double extraAmount = 0.0;

  void updatePersonCount(int count) {
    setState(() {
      personCount = count;
      extraAmount = count * 1.0; // RM 1 per person
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showFeedbackDialog(context),
            child: const Icon(Icons.mail),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () => _showPersonDialog(context),
            child: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "You invite $personCount person${personCount != 1 ? 's' : ''}"),
                        Text("You have extra RM$extraAmount"),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Today's Performance",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.flame,
                                    color: Colors.grey[600],
                                  ),
                                  const Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const _HarvestingMetric(),
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
                  completedValue: 4,
                  targetValue: 4,
                  unit: 'tonnes',
                  date: '17-10-2024',
                  extra: "2",
                  money: "RM320 (100 points)",
                ),
                const SizedBox(height: 16),
                const _ActivityCard(
                  title: 'Harvesting',
                  completedValue: 3.8,
                  targetValue: 5,
                  unit: 'tonnes',
                  date: '15-10-2024',
                  extra: "0",
                  money: "RM190",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => FeedbackDialog(),
    );
  }

  void _showPersonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PersonDialog(
        onSubmit: (int count) {
          updatePersonCount(count);
        },
      ),
    );
  }
}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Submit Feedback'),
      content: TextField(
        controller: _feedbackController,
        decoration: const InputDecoration(
          hintText: 'Enter your feedback',
        ),
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final feedback = _feedbackController.text;
            if (feedback.isNotEmpty) {
              // Handle the feedback submission
              print("Feedback submitted: $feedback");
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}

class PersonDialog extends StatefulWidget {
  final Function(int) onSubmit;

  const PersonDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PersonDialog> createState() => _PersonDialogState();
}

class _PersonDialogState extends State<PersonDialog> {
  final _personController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('One person RM 1'),
      content: TextField(
        controller: _personController,
        decoration: const InputDecoration(
          hintText: 'How many people you invite',
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final personCountText = _personController.text;
            if (personCountText.isNotEmpty) {
              final count = int.tryParse(personCountText) ?? 0;
              widget.onSubmit(count);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _personController.dispose();
    super.dispose();
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
              Colors.deepOrange[600] ?? Colors.blue,
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
                      color: Colors.deepOrange[600],
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
                    'Date :$date',
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
                    'Extra :$extra $unit',
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
