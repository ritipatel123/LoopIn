import 'package:flutter/cupertino.dart';
import 'AddCohostsScreen.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  List<String> selectedCohosts = []; // Store selected cohosts

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("New Event", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.clear, color: CupertinoColors.black),
          onPressed: () => Navigator.pop(context), // ✅ Close Event Page
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),

            // **Title**
            Center(
              child: Text(
                "Untitled Event",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),

            // **Event Cover Image Placeholder**
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CupertinoButton(
                      padding: EdgeInsets.all(10),
                      child: Icon(CupertinoIcons.pencil, size: 18, color: CupertinoColors.black),
                      onPressed: () {
                        // TODO: Implement image upload
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            // **Event Input Fields (Oval-Shaped)**
            _buildEventOption(CupertinoIcons.calendar, "Select a date"),
            _buildEventOption(CupertinoIcons.person_crop_circle, "Hosted by John Doe", isHost: true),
            _buildEventOption(CupertinoIcons.location, "Location"),
            _buildEventOption(CupertinoIcons.person_2, "Unlimited spots"),
            _buildEventOption(CupertinoIcons.money_dollar, "Cost per person"),
            _buildDescriptionField(),
            _buildEventOption(CupertinoIcons.tickets, "Open Invite"),
            _buildEventOption(CupertinoIcons.tag, "Add Tags"),
            SizedBox(height: 30),

            // **Create Event Button**
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                color: CupertinoColors.systemGrey3, // ✅ Disabled Look
                borderRadius: BorderRadius.circular(30), // ✅ Oval Shape
                onPressed: () {
                  // TODO: Handle event creation logic
                },
                child: Text(
                  "Create Event",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // **Reusable Widget for Oval Event Options**
  Widget _buildEventOption(IconData icon, String text, {bool isHost = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(30), // ✅ Oval Shape
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: CupertinoColors.black),
          SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          if (isHost)
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text("+ add cohosts", style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 14)),
              onPressed: () async {
                final cohosts = await Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => AddCohostsScreen()),
                );

                if (cohosts != null && cohosts.isNotEmpty) {
                  setState(() {
                    selectedCohosts = List<String>.from(cohosts);
                  });
                }
              },
            ),
          Icon(CupertinoIcons.chevron_down, size: 18, color: CupertinoColors.systemGrey),
        ],
      ),
    );
  }

  // **Description Field (Oval-Shaped)**
  Widget _buildDescriptionField() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(30), // ✅ Oval Shape
      ),
      child: Text(
        "Add a description of your event",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CupertinoColors.systemGrey),
      ),
    );
  }
}
