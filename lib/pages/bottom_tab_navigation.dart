import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pro_flutter/pages/posts_page.dart';
import 'package:pro_flutter/widgets/custom_circular_rect_angle.dart';
import 'package:pro_flutter/widgets/iconfont.dart';

class BottomTabNavigation extends StatefulWidget {
  @override
  _BottomTabNavigationState createState() => _BottomTabNavigationState();
}

class _BottomTabNavigationState extends State<BottomTabNavigation>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          PostsPage(),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  Container _floatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffb1a1ed),
              Color(0xff9ea8ef),
            ]),
        borderRadius: BorderRadius.circular(60)
      ),
      width: 46,
      height: 46,
      child: Icon(Icons.add, color: Colors.white,),
    );
  }

  Widget _bottomAppBar() {
    return BottomAppBar(
      elevation: 6,
      notchMargin: 6.0,
      color: Colors.white,
      shape: CustomCircularNotchedRectangle(),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 24,
                  icon: Icon(IconFont.icon_home),
                  color: _currentIndex == 0 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                IconButton(
                  iconSize: 24,
                  icon: Icon(IconFont.icon_search2),
                  color: _currentIndex == 1 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: 56,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 26,
                  icon: Icon(IconFont.icon_message),
                  color: _currentIndex == 2 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                IconButton(
                  iconSize: 24,
                  icon: Icon(IconFont.icon_user1),
                  color: _currentIndex == 3 ? Colors.black : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

