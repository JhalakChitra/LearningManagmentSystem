import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/login.dart';
import 'package:pathshala/services//auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? timer;
  bool canResend = true;
  bool checking = false;

  @override
  void initState() {
    super.initState();

    /// Start checking email verification every 3 seconds
    timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) => checkEmailVerified(),
    );
  }

  Future<void> checkEmailVerified() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await user.reload();
      final refreshed = FirebaseAuth.instance.currentUser;

      if (refreshed != null && refreshed.emailVerified) {
        timer?.cancel();

        /// Update Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(refreshed.uid)
            .update({"emailVerified": true});

        /// Navigate to login page
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
          );
        }
      }
    } catch (_) {
      // ignore errors
    }
  }

  Future<void> resendVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found. Please login again.")),
        );
        return;
      }

      if (!canResend) return;

      await user.sendEmailVerification();

      setState(() => canResend = false);

      /// Re-enable resend after 30 seconds
      Future.delayed(const Duration(seconds: 30), () {
        if (mounted) setState(() => canResend = true);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification email resent!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to resend email")),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "A verification email has been sent.\n\n"
                  "Open Gmail and click the verification link to continue.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: checking
                  ? null
                  : () async {
                setState(() => checking = true);
                await checkEmailVerified();
                setState(() => checking = false);
              },
              child: checking
                  ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text("I verified — Check now"),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: canResend ? resendVerification : null,
              child: Text(
                canResend ? "Resend Email" : "Wait 30 sec...",
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Back to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
