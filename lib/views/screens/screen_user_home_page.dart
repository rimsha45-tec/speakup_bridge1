import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:speakup_bridge/constants/colors/colors.dart';
import 'package:speakup_bridge/views/layouts/layout_home.dart';
import 'package:speakup_bridge/views/layouts/layout_notification.dart';
import 'package:speakup_bridge/views/layouts/layout_profile.dart';
import 'package:speakup_bridge/views/layouts/layout_results.dart';
import 'package:speakup_bridge/views/screens/screen_chapter_01_lesson_01_screen10.dart';
import 'package:speakup_bridge/views/screens/speakinganalysis.dart';
import 'package:speakup_bridge/views/screens/quiz_screen.dart'; // ✅ Quiz Screen Import

class ScreenUserHomePage extends StatefulWidget {
  @override
  _ScreenUserHomePageState createState() => _ScreenUserHomePageState();
}

class _ScreenUserHomePageState extends State<ScreenUserHomePage> {
  int _currentPage = 0;
  final _pageController = PageController();

  bool _isQuizCompleted = false;

  // Dummy userId, replace with actual user ID fetching logic
  String userId = 'sample_user_id';

  void _quizCompleted() {
    setState(() {
      _isQuizCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isQuizCompleted
          ? PageView(
        controller: _pageController,
        children: [
          ScreenChapter01Lesson01Screen10(),
          SpeechAnalysisScreen(),
          LayoutResults(userId: userId),
          LayoutNotification(),
          LayoutDrawer(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      )
          : QuizScreen(onQuizComplete: _quizCompleted), // ✅ Pehle Quiz Show Hogi

      bottomNavigationBar: _isQuizCompleted
          ? BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: [
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: appPrimaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.mic),
            title: Text('Speech Analysis'),
            activeColor: appPrimaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.stacked_bar_chart_outlined),
            title: Text('Stats'),
            activeColor: appPrimaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.notification_important_outlined),
            title: Text('Notify'),
            activeColor: appPrimaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: appPrimaryColor,
          ),
        ],
      )
          : null, // ✅ Jab tak quiz complete nahi hoti, bottom bar nahi dikhayenge
    );
  }
}
