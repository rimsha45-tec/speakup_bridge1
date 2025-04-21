import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DatabaseService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // Initialize new user with therapy status and FCM token
  Future<void> initializeUserData(String email, String name, int age) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(email).get();

      if (!userDoc.exists) {
        // Get FCM token
        String? fcmToken = await FirebaseMessaging.instance.getToken();

        // User data to store
        Map<String, dynamic> userData = {
          'name': name,
          'email': email,
          'age': age,
          'isActive': true,
          'token': fcmToken,
        };

        await usersCollection.doc(email).set(userData);
        print("New user initialized.");
      }
    } catch (e) {
      print("Error initializing user: $e");
      throw Exception("Failed to initialize user.");
    }
  }

  // Update user data
  Future<void> updateUserData({
    required String email,
    required String name,
    required int age,
    required bool isActive,
    String? fcmToken,
  }) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(email).get();
      Map<String, dynamic>? existingData = userDoc.data() as Map<String, dynamic>?;

      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'age': age,
        'isActive': isActive,
      };

      if (fcmToken != null) {
        userData['token'] = fcmToken;
      }

      if (existingData?['monitoring'] != null) {
        userData['monitoring'] = existingData!['monitoring'];
      }

      await usersCollection.doc(email).set(userData, SetOptions(merge: true));
      print("User data updated successfully.");
    } catch (e) {
      print("Error updating user data: $e");
      throw Exception("Failed to update user data.");
    }
  }

  // Save FCM Token
  Future<void> saveFCMToken(String email) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await usersCollection.doc(email).set({'token': fcmToken}, SetOptions(merge: true));
        print("FCM Token saved successfully.");
      }
    } catch (e) {
      print("Error saving FCM token: $e");
      throw Exception("Failed to save FCM token.");
    }
  }

  // Fetch FCM Token
  Future<String?> getFCMToken(String email) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(email).get();
      return snapshot.exists ? snapshot['token'] as String? : null;
    } catch (e) {
      print("Error retrieving FCM token: $e");
      return null;
    }
  }

  // Add a notification
  Future<void> addNotification(String email, String title, String message) async {
    try {
      await usersCollection.doc(email).collection('notifications').add({
        'title': title,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });
    } catch (e) {
      throw Exception("Failed to add notification.");
    }
  }

  // Send Welcome Notification
  Future<void> sendWelcomeNotification(String email) async {
    try {
      await usersCollection.doc(email).collection('notifications').add({
        'title': 'Welcome to Autism Connect!',
        'message': 'Thank you for signing up. We are glad to have you!',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending welcome notification: $e");
    }
  }

  // Fetch User Data
  Future<Map<String, dynamic>?> getUserData(String email) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(email).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print("User not found for email: $email");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      throw Exception("Failed to fetch user data.");
    }
  }
}
