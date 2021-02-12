import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double borderRadius;

  GradientButton(
      {@required this.child,
      this.gradient,
      this.width,
      this.height,
      this.onPressed,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print(constraints);
        return Container(
          width: width ?? constraints.maxWidth,
          height: height ?? constraints.maxHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular( borderRadius ?? 25.0),
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Theme.of(context).highlightColor.withOpacity(0.8),
                      Theme.of(context).accentColor.withOpacity(0.88),
                    ],
                    stops: [0.0, 0.88],
                  )),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onPressed,
                child: Center(
                  child: child,
                )),
          ),
        );
      },
    );
  }
}
