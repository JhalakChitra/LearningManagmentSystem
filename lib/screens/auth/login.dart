import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'package:pathshala/screens/home/homescreen.dart';
import 'package:pathshala/screens/auth/verify_email.dart';
import 'package:pathshala/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool googleLoading = false;
  bool facebookLoading = false; // NEW: Facebook loader


  // Email validation
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  // ------------------------------------------------------------------------------------
  //                                      LOGIN (EMAIL + PASSWORD)
  // ------------------------------------------------------------------------------------
  loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter valid email")));
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter password")));
      return;
    }

    setState(() => loading = true);

    final result = await AuthService().loginUser(
      email: email,
      password: password,
    );

    setState(() => loading = false);

    if (result == "success") {
      final user = FirebaseAuth.instance.currentUser;

      // Email not verified → Show Verify screen
      if (user != null && !user.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please verify your email before login"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VerifyEmailScreen()),
        );
        return;
      }

      // Verified → Go to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result!)));
    }
  }



  // ------------------------------------------------------------------------------------
  //                               GOOGLE LOGIN
  // ------------------------------------------------------------------------------------
  _googleLogin() async {
    setState(() => googleLoading = true);

    final result = await AuthService().signInWithGoogle();

    setState(() => googleLoading = false);

    if (result == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (result != "Cancelled") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }



  // ------------------------------------------------------------------------------------
  //                                 FACEBOOK LOGIN (NEW)
  // ------------------------------------------------------------------------------------
  _facebookLogin() async {
    setState(() => facebookLoading = true);

    final result = await AuthService().signInWithFacebook();

    setState(() => facebookLoading = false);

    if (result == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (result != "Cancelled") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }



  // ------------------------------------------------------------------------------------
  //                                      UI
  // ------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text("Login to continue your courses"),
                const SizedBox(height: 40),

                // ---------------- Email Input ----------------
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // ---------------- Password Input ----------------
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),
                const SizedBox(height: 30),

                // ---------------- Login Button ----------------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : loginUser,
                    child: loading
                        ? const CircularProgressIndicator(
                        color: Colors.white)
                        : const Text("Login"),
                  ),
                ),
                const SizedBox(height: 20),

                // ---------------- Divider ----------------
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),

                // ---------------- Google Login Button ----------------
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Image.asset("assets/google.png", height: 24),
                    onPressed: googleLoading ? null : _googleLogin,
                    label: googleLoading
                        ? const Text("Loading...")
                        : const Text("Sign in with Google"),
                  ),
                ),
                const SizedBox(height: 15),

                // ---------------- Facebook Login Button (UPDATED) ----------------
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Image.asset("assets/facebook.png", height: 24),
                    onPressed: facebookLoading ? null : _facebookLogin,
                    label: facebookLoading
                        ? const Text("Loading...")
                        : const Text("Sign in with Facebook"),
                  ),
                ),
                const SizedBox(height: 30),

                // ---------------- Sign Up Redirect ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
