import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Ensures horizontal centering
          children: [
            const Spacer(), // Push content down to center the logo

            // Logo Image (Centered)
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 240,
                height: 240,
              ),
            ),
            const SizedBox(height: 20),

            // Gradient Text for "Circle"
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFFF7043), // Orange shade
                    Color(0xFFFF4081), // Pink shade
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                "Circle",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Required for ShaderMask
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 5),

            // Tagline
            const Text(
              "Your campus, your circle.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFFF4081),
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            // Login Button with Gradient
            SizedBox(
              width: screenWidth * 0.8,
              height: 60, // Ensures equal height
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF7043), // Orange shade
                      Color(0xFFFF4081), // Pink shade
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30), // Fully rounded
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sign Up Button (Bordered)
            SizedBox(
              width: screenWidth * 0.8,
              height: 60, // Ensures equal height
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFFF7043), // Orange border
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF7043), // Orange text
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

