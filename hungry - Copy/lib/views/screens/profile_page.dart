import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/views/screens/All_Recipe_Page.dart';
import 'package:hungry/views/screens/auth/welcome_page.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/screens/MyRecipesSection.dart';
import 'package:hungry/views/widgets/user_info_tile.dart';
import 'package:hungry/views/screens/MyRecipesSection.dart';


class ProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String email = user?.email ?? 'No Email';
    String name = user?.displayName ?? 'Anonymous';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        title: Text('My Profile', style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w400, fontSize: 16)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Profile Picture Section
          Container(
            color: AppColor.primary,
            padding: EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () {
                print('Change profile picture tapped');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage('assets/images/hello.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Change Profile Picture', style: TextStyle(fontFamily: 'inter', fontWeight: FontWeight.w600, color: Colors.white)),
                      SizedBox(width: 8),
                      SvgPicture.asset('assets/icons/camera.svg', color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // User Info
          Container(
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoTile(label: 'Email', value: email, margin: EdgeInsets.zero),
                UserInfoTile(label: 'Full Name', value: name, margin: EdgeInsets.zero),
                UserInfoTile(label: 'Subscription Type', value: 'Premium Subscription', margin: EdgeInsets.zero),
                UserInfoTile(label: 'Subscription Time', value: 'Until 22 Oct 2026', margin: EdgeInsets.zero),
              ],
            ),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              label: Text('Logout', style: TextStyle(fontSize: 16)),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                // Navigate to login page (replace with your login screen)
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                      (route) => false,
                );
              },
            ),
          ),


          // View All New Recipes Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.restaurant_menu),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              label: Text('View All New Recipes', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllRecipesSection()),
                );
              },
            ),
          ),




          // My Recipes Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text("My Recipes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),



          /*MyRecipesSection(myRecipes: [
            {
              'name': 'Spaghetti Carbonara',
              'imageUrl': 'https://example.com/spaghetti.jpg',
              'description': 'Classic Italian pasta dish with creamy sauce.',
              'time': '20 mins',
              'ingredients': ['Pasta', 'Eggs', 'Cheese', 'Bacon'],
              'steps': ['Boil pasta', 'Fry bacon', 'Mix eggs and cheese', 'Combine everything'],
              'reviews': ['Delicious!', 'Easy to make'],
            },
            {
              'name': 'Grilled Chicken',
              'imageUrl': 'https://example.com/chicken.jpg',
              'description': 'Juicy grilled chicken with spices.',
              'time': '30 mins',
              'ingredients': ['Chicken', 'Spices', 'Oil'],
              'steps': ['Marinate chicken', 'Preheat grill', 'Cook for 15 mins'],
              'reviews': ['Super tasty!', 'Will make again'],
            },
          ]),  */

          MyRecipesSection(),


        ],
      ),
    );
  }
}
