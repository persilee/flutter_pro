import 'package:flutter/material.dart';

class BasicDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://cdn.lishaoy.net/image/36-Days.png'),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.yellowAccent[100].withOpacity(0.1), BlendMode.difference)
        )
      ),
      // color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(Icons.free_breakfast, size: 46.0, color: Colors.white,),
            // color: Color.fromRGBO(36, 156, 198, 0.6),
            padding: EdgeInsets.all(6.0),
            margin: EdgeInsets.all(3.0),
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(36, 156, 198, 0.6),
              border: Border.all(
                color: Colors.amberAccent,
                width: 1.0,
                style: BorderStyle.solid
              ),
              // borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5.0, 6.0),
                  color: Color.fromRGBO(36, 156, 198, 0.3),
                  blurRadius: 6.0,
                  spreadRadius: -1.0
                )
              ],
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}

class RichTextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'lishaoy',
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 26.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w100
        ),
        children: [
          TextSpan(
            text: '.net',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.deepPurple,
              fontWeight: FontWeight.w400
            )
          )
        ]
      ),
    );
  }
}

class TextDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '生活就如同时间一样，对每一个人都是一样的。但是却因为人与人思想、思维、心态等不同便出现了不同的生活局面，有的人过得贫苦心酸，有的人过得衣食无忧，有的人过得锦衣玉食。 面对如此落差的生活，自然就会心生埋怨或牢骚满腹。',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}