import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ Import Firestore
import 'home_screen.dart'; // Import HomeScreen

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> interests = [
    "Art", "Culture", "Fashion", "Food", "Games",
    "Movies & TV", "Music", "Social", "Sports/Fitness",
    "Studying", "Volunteering"
  ];
  final Set<String> selectedInterests = {}; // Stores selected interests
  String userName = "User"; // Default user name
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchUserName(); // ✅ Fetch user name when the screen loads
  }

  // ✅ Fetch User Name from Firestore
  Future<void> fetchUserName() async {
    try {
      String userId = "exampleUserId"; // Replace with actual user ID from auth
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name']; // Assuming 'name' field exists in Firestore
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Circle Logo
            Image.asset(
              'assets/logo.png', // Ensure this path is correct
              width: 70, // ✅ Adjusted size for navbar
              height: 70,
            ),
            SizedBox(width: 5), // ✅ Space between logo and text
            Text(
              "Circle",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF397DF6),
                fontSize: 25,
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
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 130),

              // Title
              Text(
                "Select your interests",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "Select the types of events you’re interested in.\nThese events are more likely to be suggested to you.",
                style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: 50),

              // Interest Buttons Grid with Check Circles
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: interests.map((interest) {
                    final isSelected = selectedInterests.contains(interest);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedInterests.remove(interest);
                          } else {
                            selectedInterests.add(interest);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          border: Border.all(color: CupertinoColors.black),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Circle Checkbox
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? CupertinoColors.black : CupertinoColors.white,
                                border: Border.all(color: CupertinoColors.black, width: 1.5),
                              ),
                              child: isSelected
                                  ? Icon(CupertinoIcons.check_mark, size: 12, color: CupertinoColors.white)
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Text(
                              interest,
                              style: TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Spacer(), // ✅ Pushes button to the bottom

              // "Complete" Button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Color(0xFF397DF6), // ✅ Changed to blue color
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                      print("Interests Selected: $selectedInterests");

                      // ✅ Navigate to HomeScreen with fetched username
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => HomeScreen(userName: userName),
                        ),
                      );
                    },
                    child: Text(
                      "Complete",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // ✅ Ensures some spacing below button
            ],
          ),
        ),
      ),
    );
  }
}
