import 'package:flutter/material.dart';

class IconAnimationWidget extends StatefulWidget {
  final Widget icon;
  final VoidCallback clickCallback;

  IconAnimationWidget({this.icon, this.clickCallback});

  @override
  _IconAnimationWidgetState createState() => _IconAnimationWidgetState();
}

class _IconAnimationWidgetState extends State<IconAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _iconAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    _iconAnimation = Tween(begin: 1.0, end: 1.4).animate(_animationController);

    _iconAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.4)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _iconAnimation,
      child: GestureDetector(
        child: widget.icon,
        onTap: _clickIcon,
      ),
    );
  }

  _clickIcon() async {
    if (_iconAnimation.status == AnimationStatus.forward ||
        _iconAnimation.status == AnimationStatus.reverse) {
      return;
    }
    if (_iconAnimation.status == AnimationStatus.dismissed) {
      _animationController.forward();
    } else if (_iconAnimation.status == AnimationStatus.completed) {
      _animationController.reverse();
    }
    await widget.clickCallback();
  }
}
