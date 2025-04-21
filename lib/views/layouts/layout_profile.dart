import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // Add this for sha256 hashing

import '../../Controller/controller_edit_profile.dart';
import '../../services/database.dart';
import '../screens/screen_login.dart';

class LayoutDrawer extends StatefulWidget {
  const LayoutDrawer({super.key});

  @override
  _LayoutDrawerState createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ControllerEditProfile controller = Get.put(ControllerEditProfile());
  String userName = '';
  String userEmail = '';
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String email = user.email ?? '';
      var userData = await DatabaseService().getUserData(email);

      setState(() {
        userName = userData?['name'] ?? 'User';
        userEmail = userData?['email'] ?? 'No email';
        profileImageUrl = userData?['profileImageUrl'] ?? '';
      });
    }
  }

  // Generate Gravatar-like URL based on user email
  String _generateGravatarUrl(String email) {
    final bytes = utf8.encode(email.trim().toLowerCase());
    final hash = sha256.convert(bytes).toString();
    return 'https://www.gravatar.com/avatar/$hash?d=identicon&s=200';
  }

  @override
  Widget build(BuildContext context) {
    // Determine the profile image URL to use
    String displayImage = profileImageUrl.isNotEmpty
        ? profileImageUrl
        : _generateGravatarUrl(userEmail);

    return Drawer(
      child: Column(
        children: <Widget>[
          // User profile section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: displayImage.isNotEmpty
                      ? NetworkImage(displayImage)
                      : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Menu items
          ListTile(
            leading: const Icon(Icons.account_balance_outlined, color: Color(0xff0B8EAB)),
            title: const Text('About'),
            onTap: () {
              // Navigate to the About screen
              // Uncomment and replace with actual navigation
              // Get.to(() => const ScreenAbout());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xff0B8EAB)),
            title: const Text('Log Out'),
            onTap: () async {
              // Confirm and log out
              bool confirmLogout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Log Out"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Log Out"),
                    ),
                  ],
                ),
              );

              if (confirmLogout) {
                await _firebaseAuth.signOut();
                Get.offAll(() => const ScreenLogin());
              }
            },
          ),
        ],
      ),
    );
  }
}
