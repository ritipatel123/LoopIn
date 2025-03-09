import 'package:flutter/cupertino.dart';

class AddCohostsScreen extends StatefulWidget {
  const AddCohostsScreen({super.key});

  @override
  State<AddCohostsScreen> createState() => _AddCohostsScreenState();
}

class _AddCohostsScreenState extends State<AddCohostsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allUsers = [
    {"name": "Kristina Zhao", "image": "assets/kristina.jpg"},
    {"name": "Bethany Kim", "image": "assets/bethany.jpg"},
    {"name": "Trisha Reddy", "image": "assets/trisha.jpg"},
    {"name": "Sama Dalal", "image": "assets/sama.jpg"},
    {"name": "Saikarthik Magham", "image": "assets/saikarthik.jpg"},
    {"name": "Riti Patel", "image": "assets/riti.jpg"},
    {"name": "Theanh Nguyen", "image": "assets/theanh.jpg"},
  ];
  final Set<String> _selectedCohosts = {}; // Store selected cohosts

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: CupertinoColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text("Add Cohosts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),

          // **Search Bar**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: "Search",
              padding: EdgeInsets.symmetric(vertical: 12),
              borderRadius: BorderRadius.circular(25),
              backgroundColor: CupertinoColors.systemGrey6,
              onChanged: (query) => setState(() {}), // Update UI when search query changes
            ),
          ),
          SizedBox(height: 10),

          // **List of Users**
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: _allUsers.length,
              itemBuilder: (context, index) {
                final user = _allUsers[index];
                final isSelected = _selectedCohosts.contains(user["name"]);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedCohosts.remove(user["name"]);
                      } else {
                        _selectedCohosts.add(user["name"]!);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // **User Image**
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            user["image"]!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),

                        // **User Name**
                        Expanded(
                          child: Text(
                            user["name"]!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),

                        // **Checkbox**
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            isSelected ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square,
                            size: 24,
                            color: isSelected ? Color(0xFF397DF6) : CupertinoColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                _selectedCohosts.remove(user["name"]);
                              } else {
                                _selectedCohosts.add(user["name"]!);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // **Done Button**
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              color: Color(0xFF397DF6),
              borderRadius: BorderRadius.circular(30),
              onPressed: _selectedCohosts.isNotEmpty
                  ? () {
                      // ✅ Pass selected cohosts back
                      Navigator.pop(context, _selectedCohosts.toList());
                    }
                  : null,
              child: Text(
                "Done",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
