import 'package:flutter/material.dart';
import 'package:tiktok_flutter/View/widgets/customIcon.dart';
import 'package:tiktok_flutter/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageindex = value;
          });
        },
        currentIndex: pageindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: CustomIcon(),
          ),
          BottomNavigationBarItem(
            label: "Messages",
            icon: Icon(
              Icons.message,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ],
      ),
      body: pages[pageindex],
    );
  }
}
