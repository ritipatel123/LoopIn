import 'package:flutter/cupertino.dart';
import 'interests_screen.dart'; // ✅ Import InterestsScreen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false; // Password visibility toggle

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image (Next to Text)
            Image.asset(
              'assets/logo.png', // ✅ Ensure this path is correct
              width: 70, // ✅ Adjusted for navbar size
              height: 70,
            ),
            SizedBox(width: 3), // ✅ Spacing between logo and text
            Text(
              "Circle",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF397DF6),
                fontSize: 20, // ✅ Adjusted size for better balance
              ),
            ),
          ],
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: CupertinoColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 160),

              // Title
              Text("Create an account",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              Text("Enter your information to create an account",
                  style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey)),
              SizedBox(height: 60),

              // Input Fields
              _buildInputField("First Name", "Enter your first name"),
              _buildInputField("Last Name", "Enter your last name"),
              _buildInputField("Email", "Enter your email"),

              Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              _buildPasswordField(),
              SizedBox(height: 70),

              // "Next" Button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Color(0xFF397DF6),
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => InterestsScreen()),
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Login Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: CupertinoColors.black, fontSize: 16),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Helper function to create input fields
  Widget _buildInputField(String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        CupertinoTextField(
          placeholder: placeholder,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: CupertinoColors.systemGrey),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  // ✅ Password Field with Toggle
  Widget _buildPasswordField() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CupertinoTextField(
          placeholder: "Enter a password",
          obscureText: !_isPasswordVisible,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: CupertinoColors.systemGrey),
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}


