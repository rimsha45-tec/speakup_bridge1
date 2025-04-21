import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Get the current authenticated user
  User? get currentUser => _auth.currentUser;

  // Create a CustomUser object based on Firebase User
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // Stream to listen to auth state changes (User sign in/sign out)
  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in anonymously
  Future<CustomUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error during anonymous sign-in: ${e.toString()}');
      return null;
    }
  }

  // Sign up with email and password
  Future<CustomUser?> signUpWithEmailAndPassword(
      String fullName, String email, String password, String confirmPassword) async {
    try {
      if (password != confirmPassword) {
        throw Exception("Passwords do not match");
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Add user data to Firestore
        await DatabaseService().updateUserData(
          email: email,
          name: fullName,
          isActive: true,
          age: 0, // Default age
        );

        // Save the FCM token
        await saveFCMToken(email);
        return _userFromFirebaseUser(user);
      } else {
        throw Exception("User creation failed");
      }
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  // Sign in with email and password
  Future<CustomUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Save the FCM token after successful login
        await saveFCMToken(email);

        return _userFromFirebaseUser(user);
      } else {
        throw Exception("User sign-in failed");
      }
    } catch (e) {
      print('Error during email sign-in: ${e.toString()}');
      return null;
    }
  }

  // Save the FCM token in Firestore
  Future<void> saveFCMToken(String email) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .set({'token': token}, SetOptions(merge: true));
        print("FCM token saved successfully.");
      } else {
        print("FCM token is null");
      }
    } catch (e) {
      print("Error saving FCM token: $e");
    }
  }

  // Login with Google


  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print('Error during sign-out: ${e.toString()}');
    }
  }

}
