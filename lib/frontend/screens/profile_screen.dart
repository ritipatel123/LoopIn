import 'package:flutter/cupertino.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'new_event_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final String userName = "Riti Patel";
  final String userProfileImage = "assets/profile.jpg";

  final List<Map<String, dynamic>> hostedEvents = const [
    {
      "title": "Startup Pitch Night",
      "date": "Mar 15",
      "time": "6:00 pm",
      "location": "UCLA Anderson Hall",
      "image": "assets/startup.jpg",
    },
    {
      "title": "Hackathon 2025",
      "date": "Apr 5",
      "time": "10:00 am",
      "location": "UCLA Ackerman",
      "image": "assets/hackathon.jpg",
    },
  ];

  final List<Map<String, dynamic>> joinedEvents = const [
    {
      "title": "Tech Networking Mixer",
      "date": "Mar 20",
      "time": "7:30 pm",
      "location": "Downtown LA",
      "image": "assets/networking.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.pencil, color: CupertinoColors.black),
          onPressed: () {
            // TODO: Navigate to Edit Profile Page
          },
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),

          // **Profile Picture & Name**
          Center(
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(userProfileImage, width: 100, height: 100, fit: BoxFit.cover),
                ),
                SizedBox(height: 10),
                Text(
                  userName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () {
                    // TODO: Implement edit profile functionality
                  },
                  child: Text("Edit Profile", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // **User Stats**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem("Followers", "240"),
                _buildStatItem("Following", "180"),
                _buildStatItem("Hosted", "${hostedEvents.length}"),
                _buildStatItem("Joined", "${joinedEvents.length}"),
              ],
            ),
          ),

          SizedBox(height: 30),

          // **Hosted Events Section**
          _buildSectionTitle("Events Hosted"),
          _buildEventsList(hostedEvents),

          // **Joined Events Section**
          _buildSectionTitle("Events Joined"),
          _buildEventsList(joinedEvents),

          Spacer(),

          _buildBottomNavBar(context),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEventsList(List<Map<String, dynamic>> events) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return _buildEventCard(event);
        },
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CupertinoColors.systemGrey6,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Image.asset(event["image"], width: 100, height: 80, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.calendar, size: 14, color: CupertinoColors.systemGrey),
                      SizedBox(width: 5),
                      Text(event["date"], style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.location, size: 14, color: CupertinoColors.systemGrey),
                      SizedBox(width: 5),
                      Text(event["location"], style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return CupertinoTabBar(
      onTap: (index) => _onBottomNavTap(context, index),
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_fill), label: ""),
      ],
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => HomeScreen(userName: "User")));
        break;
      case 1:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const SearchScreen()));
        break;
      case 2:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const NewEventScreen()));
        break;
      case 3:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const FavoritesScreen()));
        break;
      case 4:
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }
}
