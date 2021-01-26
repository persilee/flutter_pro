import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'iconfont.dart';

class ErrorPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String buttonText;
  final VoidCallback buttonAction;
  final VoidCallback helpAction;

  ErrorPage(
      {this.icon,
      this.title,
      this.desc,
      this.buttonText,
      this.buttonAction,
      this.helpAction});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: this.icon != null
                  ? Icon(
                      this.icon,
                      size: size.width / 3.6,
                      color: Colors.black54,
                    )
                  : Lottie.asset(
                      'assets/json/error.json',
                      width: size.width / 1.3,
                      height: 160,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 12,
              ),
              child: Text(
                this.title ?? '哦豁😯，出现了蜜汁错误！',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this.desc ?? '虽然什么也没有,要不刷新看看',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => this.helpAction(),
                  child: Icon(
                    IconFont.if_detail,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MaterialButton(
                onPressed: () => this.buttonAction(),
                child: Text(
                  this.buttonText ?? '刷新',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(6)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
