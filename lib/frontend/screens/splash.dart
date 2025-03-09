import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Ensures horizontal centering
          children: [
            Spacer(), // Push content down to center the logo

            // Logo Image (Centered)
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 170, // Adjust size as needed
                height: 170,
              ),
            ),
            SizedBox(height: 25),

            // App Name
            Text(
              "Circle",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: Color(0xFF397DF6),
              ),
            ),
            SizedBox(height: 5),

            // Tagline
            Text(
              "Your campus, your circle.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: CupertinoColors.black,
              ),
              textAlign: TextAlign.center,
            ),

            Spacer(), // Push buttons down for balance

            // Login Button
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Color(0xFF397DF6), // Blue color from the image
                borderRadius: BorderRadius.circular(30),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Sign Up Button
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Color(0xFFD6E4FF), // Light blue background from the image
                borderRadius: BorderRadius.circular(30),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xFF397DF6), // Blue text color from the image
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20), // Extra spacing before the bottom of the screen
          ],
        ),
      ),
    );
  }
}
