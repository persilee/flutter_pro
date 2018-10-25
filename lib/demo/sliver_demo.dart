import 'package:flutter/material.dart';
import '../model/post.dart';

class SliverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: < Widget > [
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8.0),
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
                children: < Widget > [
                  AspectRatio(
                    aspectRatio: 16 / 8,
                    child: Image.network(
                      posts[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Container(
                      color: Colors.black12,
                      padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: < Widget > [                         
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
                      )
                    ),

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
        childAspectRatio: 1.5
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image.network(posts[index].imageUrl, fit: BoxFit.cover, ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}