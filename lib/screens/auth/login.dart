import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'signup.dart';
import 'package:pathshala/screens/home/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Login to continue your courses"),
                const SizedBox(height: 40),

                // Email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                // Forgot password
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

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    },
                    child: const Text("Login"),
                  ),
                ),

                const SizedBox(height: 20),

                // ---- Divider OR text ----
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

                // ==== Google SignIn Button ====
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Image.asset(
                      "assets/google.png",
                      height: 24,
                    ),
                    onPressed: () {
                      // TODO: integrate google login
                    },
                    label: const Text("Sign in with Google"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ==== Facebook SignIn Button ====
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Image.asset(
                      "assets/facebook.png",
                      height: 24,
                    ),
                    onPressed: () {
                      // TODO: integrate facebook login
                    },
                    label: const Text("Sign in with Facebook"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Sign Up button
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
