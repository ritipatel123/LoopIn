import 'package:flutter/cupertino.dart';

class NotificationsScreen extends StatelessWidget {
   NotificationsScreen({super.key});

  // Dummy Notification Data
  final List<Map<String, String>> todayNotifications = [
    {"name": "Lauren Hajadi", "message": "is going to your Circle Demo", "image": "assets/profile1.jpg"},
    {"name": "Nalin Jayaswal", "message": "is going to your Circle Demo", "image": "assets/profile2.jpg"},
    {"name": "Rajveer Batra", "message": "is going to your Circle Demo", "image": "assets/profile3.jpg"},
  ];

  final List<Map<String, String>> yesterdayNotifications = [
    {"name": "Inman Costa", "message": "is going to your Circle Demo", "image": "assets/profile4.jpg"},
    {"name": "Ria Pandey", "message": "is going to your Circle Demo", "image": "assets/profile5.jpg"},
    {"name": "Rosey Choi", "message": "is going to your Circle Demo", "image": "assets/profile6.jpg"},
  ];

  final List<Map<String, String>> lastWeekNotifications = [
    {"name": "Theanh Nguyen", "message": "is going to your Circle Demo", "image": "assets/profile7.jpg"},
    {"name": "Riti Patel", "message": "is going to your Circle Demo", "image": "assets/profile8.jpg"},
    {"name": "Saikarthk Magham", "message": "is going to your Circle Demo", "image": "assets/profile9.jpg"},
    {"name": "Bethany Kim", "message": "is going to your Circle Demo", "image": "assets/profile10.jpg"},
    {"name": "Kristina Zhao", "message": "is going to your Circle Demo", "image": "assets/profile11.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Notifications", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection("Today", todayNotifications),
              _buildSection("Yesterday", yesterdayNotifications),
              _buildSection("Last Week", lastWeekNotifications),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each section with notifications
  Widget _buildSection(String title, List<Map<String, String>> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Column(
          children: notifications.map((notification) => _buildNotificationItem(notification)).toList(),
        ),
      ],
    );
  }

  // Function to build each notification row
  Widget _buildNotificationItem(Map<String, String> notification) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Circular Profile Image
          ClipOval(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemGrey3, // Placeholder for image
              ),
              child: Image.asset(notification["image"]!, fit: BoxFit.cover), // Load image from assets
            ),
          ),
          SizedBox(width: 10),

          // Name & Message
          Expanded(
            child: Text.rich(
              TextSpan(
                text: "${notification["name"]} ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                children: [
                  TextSpan(
                    text: notification["message"],
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

