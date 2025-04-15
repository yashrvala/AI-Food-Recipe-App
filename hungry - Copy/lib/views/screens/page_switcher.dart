import 'package:flutter/material.dart';
import 'package:hungry/views/screens/bookmarks_page.dart';
import 'package:hungry/views/screens/new_Chat.dart';
import 'new_add_page.dart';
import 'package:hungry/views/screens/explore_page.dart';
import 'package:hungry/views/screens/home_page.dart';
import 'package:hungry/views/utils/AppColor.dart';
import 'package:hungry/views/widgets/custom_bottom_navigation_bar.dart';

class PageSwitcher extends StatefulWidget {
  final int initialIndex;
  const PageSwitcher({this.initialIndex = 0, Key? key}) : super(key: key);
  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          [
            HomePage(),
            ExplorePage(),
            AddRecipePage(),
            BookmarksPage(),
            AIChatPage(),
          ][_selectedIndex],
          if (_selectedIndex != 4) BottomGradientWidget(),



        ],
      ),

       bottomNavigationBar: _selectedIndex == 4
          ? null // Hide navbar on AIChatPage
          : CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),


      //bottomNavigationBar: CustomBottomNavigationBar(onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
    );
  }
}

class BottomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(gradient: AppColor.bottomShadow),
      ),
    );
  }
}
