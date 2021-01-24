import 'package:flutter/material.dart';
import 'package:pro_flutter/demo/model/post.dart';

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar(
          //   // title: Text('Lishaoy.net'),
          //   // pinned: true,
          //   // backgroundColor: Colors.yellowAccent[300],
          //   floating: true,
          //   expandedHeight: 175.0,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: Text(
          //       'lishaoy.net'.toUpperCase(),
          //       style: TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.w300,
          //         letterSpacing: 3.0,
          //       ),
          //     ),
          //     background: Image.network('https://cdn.lishaoy.net/image/HIM.webp', fit: BoxFit.cover,),
          //   ),
          // ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverListDemo(),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 26.0),
            child: Material(
              elevation: 16.0,
              shadowColor: Colors.grey.withOpacity(0.6),
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        posts[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Container(
                        color: Colors.black12,
                        padding:
                            EdgeInsets.only(left: 4.0, right: 4.0, bottom: 3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              posts[index].title,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              posts[index].author,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                height: 1.2,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}

class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.5),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
              child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                posts[index].imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10.0,
                left: 8.0,
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        posts[index].title,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        posts[index].author,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
        },
        childCount: posts.length,
      ),
    );
  }
}
