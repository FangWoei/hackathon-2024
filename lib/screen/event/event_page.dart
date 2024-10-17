import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ZoneEntry {
  final String name;
  final double completion;
  final int target;
  final int daysLeft;
  final String imageURL;

  ZoneEntry(
      {required this.name,
      required this.completion,
      required this.target,
      required this.daysLeft,
      required this.imageURL});
}

class TeamPage extends StatelessWidget {
  final List<ZoneEntry> entries = [
    ZoneEntry(
        name: "Zone 1",
        completion: 0.60,
        target: 40,
        daysLeft: 10,
        imageURL: 'assets/images/zon1.png'),
    ZoneEntry(
        name: "Zone 2",
        completion: 0.85,
        target: 30,
        daysLeft: 5,
        imageURL: 'assets/images/zon2.png'),
    ZoneEntry(
        name: "Zone 2",
        completion: 0.85,
        target: 30,
        daysLeft: 5,
        imageURL: 'assets/images/zon1.png'),
    ZoneEntry(
        name: "Zone 2",
        completion: 0.85,
        target: 30,
        daysLeft: 5,
        imageURL: 'assets/images/zon2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Best Team: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Team 2',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: Card(
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
                            'Team Members',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Jane Smith',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                          'Team Performance',
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
                const Text(
                  'Zones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 1000,
                          child: Stack(children: [
                            Container(
                              constraints:
                                  const BoxConstraints.expand(height: 850),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/bg.png'),
                                      fit: BoxFit.cover)),
                            ),
                            // GridView.count(
                            //   crossAxisCount: 2,
                            //   children: [
                            //     ElevatedButton(
                            //       onPressed: () {
                            //         print('Button pressed');
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //           backgroundColor: Colors.white.withOpacity(
                            //               0.8), // Semi-transparent background
                            //           foregroundColor: Colors.black,
                            //           fixedSize: Size(120, 240),
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.zero)),
                            //       child: Text('Button'),
                            //     ),
                            //   ],
                            // )
                            GridView.builder(
                                itemCount: 4,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  mainAxisExtent: 425,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemBuilder: (context, index) {
                                  double height = (index > 1) ? 150 : 750;
                                  return Container(
                                    height: height,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _showPersonDialog(context, index + 1);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white.withOpacity(
                                              0.2), // Semi-transparent background
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                      child: Text('Zone ${index + 1}'),
                                    ),
                                  );
                                })
                          ]),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPersonDialog(BuildContext context, int zone) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PersonDialog(zone: zone),
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
              '9.8 tonnes',
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
            value: 0.6,
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
              'Target: 15 tonnes',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Time left:1 week',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Done: 60%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PersonDialog extends StatefulWidget {
  final int zone;

  const PersonDialog({super.key, required this.zone});

  @override
  State<PersonDialog> createState() => _PersonDialogState();
}

class _PersonDialogState extends State<PersonDialog> {
  final _personController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Current Locations'),
      content: Container(
        height: 500,
        child: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 400),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/zon${widget.zone}.png'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 100, // Y-axis position (vertical)
              left: 150, // X-axis position (horizontal)
              child: MarkerWidget(
                initials: 'CV', // Example initials
                backgroundColor: Colors.blue,
              ),
            ),
            Positioned(
              top: 200,
              left: 120,
              child: MarkerWidget(
                initials: 'AB',
                backgroundColor: Colors.red,
              ),
            ),
            Positioned(
              top: 300,
              left: 100,
              child: MarkerWidget(
                initials: 'LM',
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
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

class MarkerWidget extends StatelessWidget {
  final String initials;
  final Color backgroundColor;

  const MarkerWidget({
    Key? key,
    required this.initials,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.9), // Marker background color
        shape: BoxShape.circle, // Circular marker
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
