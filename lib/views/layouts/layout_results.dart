import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:speakup_bridge/widgtes/medium_text.dart';

class LayoutResults extends StatefulWidget {
  final String userId;
  const LayoutResults({Key? key, required this.userId}) : super(key: key);

  @override
  _LayoutResultsState createState() => _LayoutResultsState();
}

class _LayoutResultsState extends State<LayoutResults> {
  Map<String, dynamic>? progressData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProgress();
  }

  Future<void> fetchUserProgress() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('user_progress')
          .doc(widget.userId)
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          progressData = doc.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          progressData = {};
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculatePercentage(int count) {
    return count.clamp(0, 100) / 100;  // Ensures values are between 0 and 100
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Results"), centerTitle: true),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (progressData == null || progressData!.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Results"), centerTitle: true),
        body: Center(child: Text("No data available.")),
      );
    }

    int reading = progressData?["reading"] ?? 0;
    int speaking = progressData?["speaking"] ?? 0;
    int writing = progressData?["writing"] ?? 0;
    int listening = progressData?["listening"] ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text("Results"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.sp),
            Center(
              child: MultiCircularSlider(
                size: MediaQuery.of(context).size.width * 0.8,
                progressBarType: MultiCircularSliderType.circular,
                values: [
                  calculatePercentage(speaking),
                  calculatePercentage(listening),
                  calculatePercentage(writing),
                  calculatePercentage(reading)
                ],
                colors: [
                  Color(0xFFFD1960),
                  Color(0xFF29D3E8),
                  Color(0xFF18C737),
                  Color(0xFFFFCC05)
                ],
                showTotalPercentage: true,
                label: 'Overall Progress',
                animationDuration: Duration(milliseconds: 800),
                animationCurve: Curves.easeIn,
                innerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${((reading + speaking + writing + listening) / 4).toStringAsFixed(0)}%',
                        style: TextStyle(fontSize: 40)),
                    Text('Overall Percentage', style: TextStyle(fontSize: 22)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            buildProgressRow("Speaking", speaking, Color(0xFFFD1960)),
            buildProgressRow("Listening", listening, Color(0xFF29D3E8)),
            buildProgressRow("Writing", writing, Color(0xFF18C737)),
            buildProgressRow("Reading", reading, Color(0xFFFFCC05)),
          ],
        ),
      ),
    );
  }

  Widget buildProgressRow(String label, int count, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediumText(text: label),
          CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 5.0,
            percent: calculatePercentage(count),
            center: Text("${(calculatePercentage(count) * 100).toStringAsFixed(0)}%"),
            progressColor: color,
          )
        ],
      ),
    );
  }
}
