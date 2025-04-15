import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRecipesSection extends StatelessWidget {
  const MyRecipesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('recipes')
          .where('userEmail', isEqualTo: currentUserEmail)
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No recipes added yet."));
        }

        final myRecipes = snapshot.data!.docs;

        return Column(
          children: myRecipes.map((doc) {
            final recipe = doc.data() as Map<String, dynamic>;
            recipe['id'] = doc.id; // Add document ID to recipe
            return RecipeCard(recipe: recipe);
          }).toList(),
        );

      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              recipe['imageUrl'] ?? '',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 150,
                color: Colors.grey[300],
                child: Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),

          // Recipe Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(recipe['description'] ?? '', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                SizedBox(height: 4),
                Text("Time: ${recipe['time'] ?? 'N/A'}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ),
          ),

          // Tabbed Section
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "Ingredients"),
                    Tab(text: "Steps"),
                    Tab(text: "Reviews"),
                  ],
                ),
                Container(
                  height: 120,
                  child: TabBarView(
                    children: [
                      ListView(
                        padding: EdgeInsets.all(8),
                        children: (recipe['ingredients'] as List<dynamic>? ?? []).map<Widget>(
                              (item) => Text("• $item"),
                        ).toList(),
                      ),
                      ListView(
                        padding: EdgeInsets.all(8),
                        children: (recipe['steps'] as List<dynamic>? ?? []).map<Widget>(
                              (step) => Text("➡ $step"),
                        ).toList(),
                      ),

                      // Reviews Tab
                      Stack(
                        children: [
                          ListView(
                            padding: EdgeInsets.all(8),
                            children: (recipe['reviews'] as List<dynamic>? ?? []).map<Widget>(
                                  (review) => Card(
                                margin: EdgeInsets.only(bottom: 8),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("⭐ $review"),
                                ),
                              ),
                            ).toList(),
                          ),
                        ],
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

