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
              sliver: SliverGridDemo(),
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
              borderRadius: BorderRadius.circular(12.0),
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
                    top: 36.0,
                    left: 36.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          posts[index].title,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          posts[index].author,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w200,
                            color: Colors.white
                          ),
                        ),
                      ],
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