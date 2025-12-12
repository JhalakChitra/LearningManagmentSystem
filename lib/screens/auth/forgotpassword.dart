import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  bool loading = false;

  // ---------------- Email Validation ----------------
  bool isValidEmail(String email) {
    final pattern = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return pattern.hasMatch(email);
  }

  // ---------------- Reset Password ----------------
  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showMessage("Please enter an email");
      return;
    }

    if (!isValidEmail(email)) {
      showMessage("Enter a valid email address");
      return;
    }

    setState(() => loading = true);

    try {
      await auth.sendPasswordResetEmail(email: email);

      showMessage("Password reset link sent to your email");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String msg = "";
      if (e.code == 'user-not-found') {
        msg = "No user found with this email";
      } else {
        msg = e.message ?? "Something went wrong";
      }

      showMessage(msg);
    }

    setState(() => loading = false);
  }

  // ---------------- Helper Snackbar ----------------
  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your registered email. A password reset link will be sent.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 25),

            // Email Input
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Reset Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : resetPassword,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Send Reset Link",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
