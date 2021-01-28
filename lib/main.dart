import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_flutter/demo/base_widget_demo/my_page.dart';
import 'package:pro_flutter/pages/posts_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';
import 'demo/base_widget_demo/basic_demo.dart';
import 'demo/base_widget_demo/components_demo.dart';
import 'demo/base_widget_demo/drawer_demo.dart';
import 'demo/base_widget_demo/navigator_demo.dart' as NavPage;
import 'demo/base_widget_demo/forms_demo.dart';
import 'demo/base_widget_demo/layout_demo.dart';
import 'demo/base_widget_demo/view_demo.dart';
import 'demo/base_widget_demo/sliver_demo.dart';
import 'demo/base_widget_demo/card_demo.dart';
import 'demo/router_page.dart';

void main() async {
  debugPaintSizeEnabled = false; //显示边界布局
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
  await SpUtil.getInstance();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(style);
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Home(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/about': (context) => NavPage.Page(
                title: 'About',
              ),
          '/form': (context) => FormsDemo(),
          '/components': (context) => ComponentsDome(),
        },
        theme: ThemeData(
          primaryColor: Colors.yellow,
          accentColor: Colors.amber,
          highlightColor: Color.fromRGBO(255, 255, 255, 0.6),
          splashColor: Colors.white70,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Lishaoy.net'.toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 3.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => debugPrint('Search Button is pressed'),
            )
          ],
          elevation: 0.0,
          bottom: _getBottom(),
        ),
        body: _getPages(),
        drawer: DrawerDemo(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black87,
          currentIndex: _currentIndex,
          onTap: _onTapHandler,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 0
                      ? "assets/images/home.png"
                      : "assets/images/off_home.png",
                  height: 27.0,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 1
                      ? "assets/images/history.png"
                      : "assets/images/off_history.png",
                  height: 28.0,
                ),
                label: 'Demo'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 2
                      ? "assets/images/Listview.png"
                      : "assets/images/off_Listview.png",
                  height: 28.0,
                ),
                label: 'List'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 3
                      ? "assets/images/wode.png"
                      : "assets/images/off_wode.png",
                  height: 30.0,
                ),
                label: 'My'),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _getBottom() {
    if (false) {
      return TabBar(
        isScrollable: false,
        unselectedLabelColor: Colors.black38,
        indicatorColor: Colors.black54,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 1.0,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.shopping_cart)),
          Tab(icon: Icon(Icons.spa)),
          Tab(icon: Icon(Icons.star)),
          Tab(icon: Icon(Icons.apps)),
        ],
      );
    } else {
      return null;
    }
  }

  Widget _getPages() {
    switch (_currentIndex) {
      case 0:
        return TabBarView(
          children: <Widget>[
            PostsPage(),
            // Icon(Icons.spa, size: 126.0, color: Colors.black12,),
            BasicDemo(),
            // Icon(Icons.star, size: 126.0, color: Colors.black12,),
            LayoutDemo(),
            ViewDemo(),
          ],
        );
        break;
      case 1:
        return RouterPage();
        break;
      case 2:
        return SliverDemo();
        break;
      case 3:
        return MyPage();
        break;
      default:
        return null;
        break;
    }
  }
}
