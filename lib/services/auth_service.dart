import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Google Sign-In instance
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------- Register User ----------------
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return "Failed to create user";

      await user.sendEmailVerification();

      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'emailVerified': false,
      });

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return 'This email is already registered.';
      if (e.code == 'invalid-email') return 'Invalid email address.';
      if (e.code == 'weak-password') return 'Password should be at least 6 characters.';
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------------- Login User ----------------
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return "User not found";

      if (!user.emailVerified) {
        await _auth.signOut();
        return 'Please verify your email before logging in.';
      }

      await _firestore.collection('users').doc(user.uid).update({
        'emailVerified': true,
      });

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return "User not found";
      if (e.code == 'wrong-password') return "Incorrect password";
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------------- GOOGLE SIGN-IN ----------------
  Future<String> signInWithGoogle() async {
    try {
      // Force showing account chooser
      await _googleSignIn.signOut();
      // DO NOT call disconnect() here (causes PlatformException)

      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();
      if (googleUser == null) return "Cancelled";

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  // ---------------- Reset Password ----------------
  Future<String?> sendPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------------- Sign Out ----------------
  Future<void> signOut() async {
    await _auth.signOut();

    try {
      // SAFE use of disconnect() – only on logout
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.disconnect();
      }
      await _googleSignIn.signOut();
    } catch (e) {
      print("Google sign-out error: $e");
    }
  }
}

// ---------------- Utilities ----------------
bool isValidEmail(String email) {
  return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
}
