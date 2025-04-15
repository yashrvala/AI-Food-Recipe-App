import 'package:flutter/material.dart';

class New_RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  New_RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['name'])),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Image.network(recipe['imageUrl'], fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe['description'], style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text("⏳ ${recipe['time']}", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: "Ingredients"),
                      Tab(text: "Goods"),
                      Tab(text: "Reviews"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildList(recipe['ingredients']),
                        _buildList(recipe['steps']),
                        _buildList(recipe['reviews']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<dynamic> items) {
    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) => Text("• ${items[index]}", style: TextStyle(fontSize: 14)),
    );
  }
}
