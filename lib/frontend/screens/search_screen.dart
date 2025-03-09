import 'package:flutter/cupertino.dart';
import 'notifications_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = "All"; // Default category
  final List<String> categories = ["All", "Art", "Culture", "Fashion", "Food"];
  final List<Map<String, String>> _searchResults = [
    {
      "title": "Topdog/Underdog",
      "date": "FEB 28",
      "time": "7:15 pm",
      "location": "Pasadena Playhouse",
      "category1": "Art",
      "category2": "Culture",
      "hostedBy": "👤",
    },
    {
      "title": "LACMA Modern Art Tour",
      "date": "MAR 2",
      "time": "1:00 pm",
      "location": "LACMA",
      "category1": "Art",
      "category2": "",
      "hostedBy": "👥 +2 others",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        middle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png', // Ensure correct path
              width: 30,
              height: 30,
            ),
            SizedBox(width: 5),
            Text(
              "Circle",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF397DF6), // Blue color for branding
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
        children: [
          SizedBox(height: 20),

          // **Search Bar**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: "Search",
              padding: EdgeInsets.symmetric(vertical: 12),
              borderRadius: BorderRadius.circular(25),
              backgroundColor: CupertinoColors.systemGrey6,
            ),
          ),
          SizedBox(height: 150),

          // **Category Filters**
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: categories.map((category) {
                bool isSelected = category == selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    color: isSelected ? Color(0xFF397DF6) : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10),

          // **Event List**
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final event = _searchResults[index];
                return _buildEventCard(
                  event["title"]!,
                  event["date"]!,
                  event["time"]!,
                  event["location"]!,
                  event["category1"]!,
                  event["category2"]!,
                  event["hostedBy"]!,
                );
              },
            ),
          ),

          // **Bottom Navigation Bar**
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // **Event Card Widget**
  Widget _buildEventCard(String title, String date, String time, String location, String category1, String category2, String hostedBy) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: CupertinoColors.systemGrey5),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey3.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // **Event Image Placeholder**
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: [
                    _buildCategoryTag(category1),
                    SizedBox(width: 5),
                    category2.isNotEmpty ? _buildCategoryTag(category2) : SizedBox(),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CupertinoButton(
                  padding: EdgeInsets.all(5),
                  child: Icon(CupertinoIcons.heart, color: CupertinoColors.white),
                  onPressed: () {
                    // TODO: Handle favorite event
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
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("hosted by ", style: TextStyle(color: CupertinoColors.systemGrey)),
                    Text(hostedBy, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(CupertinoIcons.clock, size: 16, color: CupertinoColors.systemGrey),
                    SizedBox(width: 5),
                    Text(time, style: TextStyle(color: CupertinoColors.systemGrey)),
                    SizedBox(width: 10),
                    Icon(CupertinoIcons.location, size: 16, color: CupertinoColors.systemGrey),
                    SizedBox(width: 5),
                    Text(location, style: TextStyle(color: CupertinoColors.systemGrey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // **Category Tag Widget**
  Widget _buildCategoryTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CupertinoColors.black),
      ),
      child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  // **Bottom Navigation Bar**
  Widget _buildBottomNavBar() {
    return CupertinoTabBar(
      activeColor: CupertinoColors.black,
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: ""),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ""),
      ],
    );
  }
}
