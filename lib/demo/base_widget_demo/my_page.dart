import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/flare_demo/flare_sign_in_demo.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  Future<void> _handleRefresh() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(249, 249, 249, 1)),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: Colors.yellow,
            backgroundColor: Colors.black38,
            child: ListView(
              children: <Widget>[
                Container(
                  height: 186,
                  padding: EdgeInsets.only(top: 36),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffffeb3b),
                          Color(0x6fffeb3b),
                        ]),
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/icon.png',
                        width: 58,
                        height: 58,
                      ),
                      Text(
                        'Flutter Case',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/icon_accountNumber.png',
                                  height: 19,
                                  width: 18,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  'account',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '012347668',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(102, 102, 102, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Color.fromRGBO(235, 235, 235, 1),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icon_accountPassword.png',
                                    height: 19,
                                    width: 18,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                  ),
                                  Text(
                                    'reset password',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icon_accountAbout.png',
                                    height: 19,
                                    width: 18,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                  ),
                                  Text(
                                    'about',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: RaisedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlareSignInDemo()));
                    },
                    splashColor: Colors.yellow[400],
                    elevation: 0.0,
                    color: Colors.white,
                    padding: EdgeInsets.all(12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
