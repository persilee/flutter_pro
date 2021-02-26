import 'package:flutter/material.dart';
import 'package:pro_flutter/pages/message_page.dart';
import 'package:pro_flutter/pages/home/posts_page.dart';
import 'package:pro_flutter/pages/profile/profile_page.dart';
import 'package:pro_flutter/pages/search_page.dart';
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
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
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
          SearchPage(),
          MessagePage(),
          ProfilePage(),
        ],
        onPageChanged: (page) {},
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
                Theme.of(context).highlightColor,
                Theme.of(context).accentColor,
              ]),
          borderRadius: BorderRadius.circular(60)),
      width: 46,
      height: 46,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
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
                _createIconButton(0,icon: Icon(IconFont.icon_home)),
                _createIconButton(1,icon: Icon(IconFont.icon_search2)),
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
                _createIconButton(2,icon: Icon(IconFont.icon_message), iconSize: 26),
                _createIconButton(3,icon: Icon(IconFont.icon_user1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _createIconButton(int index ,{Icon icon, double iconSize}) {
    return IconButton(
      iconSize: iconSize ?? 26,
      icon: icon ?? Icon(IconFont.icon_home),
      color: _currentIndex == index ? Colors.black : Colors.grey,
      onPressed: () {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex,
              curve: Curves.easeIn, duration: Duration(milliseconds: 160));
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => false; // 是否缓存tab页面数据
}
