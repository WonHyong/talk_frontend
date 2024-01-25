import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotalk_frontend/src/ui/screen/my_page.dart';
import 'package:lotalk_frontend/src/ui/screen/post_list.dart';
import 'package:lotalk_frontend/src/ui/screen/setting_page.dart';

import '../../repository/post_repository.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();

}



class _HomePageState extends State<HomePage>{
  int _page = 0;
  late PageController pageController;

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: [
          Container(color: Colors.white, child: PostList(repository: PostRepository.instance)),
          Container(color: Colors.white, child: const ChatPage()),
          Container(color: Colors.white, child: const MyPage()),
          Container(color: Colors.white, child: const SettingPage()),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.orange,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: (_page == 0) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded, color: (_page == 1) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded, color: (_page == 2) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: (_page == 3) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}