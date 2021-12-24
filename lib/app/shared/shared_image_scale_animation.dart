import 'package:flutter/material.dart';

class SharedImageScaleAnimation extends StatefulWidget {
  const SharedImageScaleAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 8),
  }) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  _ImageScaleAnimationState createState() => _ImageScaleAnimationState();
}

class _ImageScaleAnimationState extends State<SharedImageScaleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double scale = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation.addListener(() {
      //print('scaleanimation ${animation.value}');
      setState(() {
        scale = 1 + (animation.value * 20 / 100);
        //print('scale=${scale}');
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.zero),
      child: Transform.scale(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
