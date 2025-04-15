import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const RecipeCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          // Left: Image
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(data['imageUrl'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 12),

          // Right: Description and Tabs
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'] ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(data['description'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: 8),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Ingredients'),
                          Tab(text: 'Steps'),
                          Tab(text: 'Reviews'),
                        ],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        indicatorColor: Colors.orange,
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      Container(
                        height: 80,
                        child: TabBarView(
                          children: [
                            ListView(
                              children: (data['ingredients'] as List<dynamic>?)?.map((item) => Text("• $item")).toList() ?? [],
                            ),
                            ListView(
                              children: (data['steps'] as List<dynamic>?)?.map((step) => Text("• $step")).toList() ?? [],
                            ),
                            Text("No reviews yet."),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
