import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final bool isCircle;

  SkeletonLoader({
    Key key,
    @required this.width,
    @required this.height,
    this.isCircle = false,
  }) : super(key: key);

  @override
  _SkeletonLoaderState createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    this.controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    gradientPosition = Tween<double>(begin: -3, end: 10).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });

    this.controller.repeat();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.isCircle ? 100 / 2 : 10.0),
        gradient: LinearGradient(
          begin: Alignment(this.gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [
            Colors.grey.withOpacity(0.05),
            Colors.grey.withOpacity(0.15),
            Colors.grey.withOpacity(0.4),
          ],
        ),
      ),
    );
  }
}
