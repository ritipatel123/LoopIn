import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications_screen.dart';
import 'search_screen.dart';
import 'new_event_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  Future<List<Map<String, dynamic>>> fetchEvents(String category) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('category', isEqualTo: category)
        .orderBy('date', descending: false)
        .limit(5)
        .get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 70,
              height: 70,
            ),
            SizedBox(width: 5),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 130),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hi, $userName",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(25),
              ),
              child: CupertinoSearchTextField(
                padding: EdgeInsets.symmetric(vertical: 12),
                borderRadius: BorderRadius.circular(25),
                backgroundColor: CupertinoColors.systemGrey6,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildSectionTitle(context, "Trending Events"),
          _buildDynamicEventList("Trending"),
          _buildSectionTitle(context, "Events Near You"),
          _buildDynamicEventList("Nearby"),
          Spacer(),
          _buildBottomNavBar(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Text("see more", style: TextStyle(color: CupertinoColors.black)),
                Icon(CupertinoIcons.forward, size: 16, color: CupertinoColors.black),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicEventList(String category) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchEvents(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No events available"));
        }
        return SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: snapshot.data!.map((event) => _buildEventCard(event)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CupertinoColors.systemGrey6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(event["imageUrl"] ?? "https://via.placeholder.com/150"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event["category"], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                Text(event["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hosted by 👤", style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
                    Text(event["date"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
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
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.search)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
      ],
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => HomeScreen(userName: userName)),
        );
        break;
      case 1:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const NewEventScreen()),
        );
        break;
      case 3:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const FavoritesScreen()),
        );
        break;
      case 4:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}

