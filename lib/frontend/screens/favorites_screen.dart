import 'package:flutter/cupertino.dart';
import 'notifications_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'new_event_screen.dart';
import 'profile_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  final List<Map<String, dynamic>> favoriteEvents = const [
    {
      "title": "Lakers vs. Mavericks",
      "category": ["Social"],
      "date": "Feb 25",
      "time": "6:00 pm",
      "location": "Crypto Arena",
      "image": "assets/lakers_game.jpg",
      "hosts": ["assets/host1.jpg", "assets/host2.jpg"],
      "attendees": 15,
    },
    {
      "title": "Long Beach Symphony",
      "category": ["Art", "Music"],
      "date": "Mar 8",
      "time": "7:00 pm",
      "location": "Terrace Theater",
      "image": "assets/symphony.jpg",
      "hosts": ["assets/host3.jpg"],
      "attendees": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Text(
          "Your Likes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.bell_fill, color: CupertinoColors.black),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => NotificationsScreen()),
            );
          },
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: favoriteEvents.length,
              itemBuilder: (context, index) {
                final event = favoriteEvents[index];
                return _buildEventCard(event);
              },
            ),
          ),
          _buildBottomNavBar(context),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey4,
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Event Image with Overlay**
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(event["image"], height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: event["category"]
                      .map<Widget>((cat) => _buildCategoryTag(cat))
                      .toList(),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CupertinoButton(
                  padding: EdgeInsets.all(5),
                  child: Icon(CupertinoIcons.heart_fill, color: CupertinoColors.black, size: 28),
                  onPressed: () {
                    // TODO: Implement remove from favorites functionality
                  },
                ),
              ),
            ],
          ),

          // **Event Details**
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event["title"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("hosted by ", style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
                    ...event["hosts"].map((host) => _buildHostAvatar(host)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(CupertinoIcons.clock, size: 16, color: CupertinoColors.systemGrey),
                    SizedBox(width: 5),
                    Text(event["time"], style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
                    SizedBox(width: 10),
                    Icon(CupertinoIcons.location, size: 16, color: CupertinoColors.systemGrey),
                    SizedBox(width: 5),
                    Text(event["location"], style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(CupertinoIcons.person_2_fill, size: 16, color: CupertinoColors.systemGrey),
                    SizedBox(width: 5),
                    Text("+ ${event["attendees"]} others", style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CupertinoColors.black),
      ),
      child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHostAvatar(String hostImage) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: ClipOval(
        child: Image.asset(hostImage, width: 20, height: 20, fit: BoxFit.cover),
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
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart_fill), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ""),
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
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const FavoritesScreen()));
        break;
      case 4:
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }
}
