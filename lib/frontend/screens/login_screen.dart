import 'package:flutter/cupertino.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false; // Tracks password visibility

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      navigationBar: CupertinoNavigationBar(
        border: null, // Removes bottom border for a cleaner look
        backgroundColor: CupertinoColors.white,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // ✅ Use the asset image
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 5),
            Text(
              "Circle",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color(0xFF397DF6),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back, color: CupertinoColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 100),

              // Email Input
              const Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CupertinoColors.black),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                placeholder: "Enter your email",
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(height: 20),

              // Password Input
              const Text(
                "Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CupertinoColors.black),
              ),
              const SizedBox(height: 8),
              CupertinoTextField(
                placeholder: "Enter your password",
                obscureText: !_isPasswordVisible,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                suffix: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    color: CupertinoColors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Add forgot password action here
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button - ✅ MATCHES SPLASH SCREEN BUTTON
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 15), // Matches SplashScreen
                    color: const Color(0xFF397DF6), // ✅ Blue color from SplashScreen
                    borderRadius: BorderRadius.circular(30), // ✅ Rounded edges
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      // Handle login logic
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Signup Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


