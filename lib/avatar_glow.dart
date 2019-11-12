library avatar_glow;

import 'dart:async';

import 'package:flutter/material.dart';

class AvatarGlow extends StatefulWidget {
  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool isAnimating;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration startDelay;

  const AvatarGlow({
    Key key,
    @required this.child,
    @required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.isAnimating = true,
    this.repeatPauseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.fastOutSlowIn,
    this.showTwoGlows = true,
    this.glowColor = Colors.white,
    this.startDelay,
  }) : super(key: key);

  @override
  _AvatarGlowState createState() => _AvatarGlowState();
}

class _AvatarGlowState extends State<AvatarGlow>
    with SingleTickerProviderStateMixin {
  Animation<double> smallDiscAnimation;
  Animation<double> bigDiscAnimation;
  Animation<double> alphaAnimation;
  AnimationController controller;
  void Function(AnimationStatus status) listener;

  @override
  void initState() {
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _createAnimation();

    if (widget.isAnimating) {
      _startAnimation();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(AvatarGlow oldWidget) {
    // Fields which will trigger new animation values
    if (widget.duration != oldWidget.duration ||
        widget.curve != oldWidget.curve ||
        widget.endRadius != oldWidget.endRadius) {
      controller.duration = widget.duration;
      _createAnimation();
    }

    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _createAnimation() {
    final Animation curve = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );

    smallDiscAnimation = Tween(
      begin: (widget.endRadius * 2) / 6,
      end: (widget.endRadius * 2) * (3 / 4),
    ).animate(curve);

    bigDiscAnimation = Tween(
      begin: 0.0,
      end: (widget.endRadius * 2),
    ).animate(curve);

    alphaAnimation = Tween(begin: 0.30, end: 0.0).animate(controller);

    controller.removeStatusListener(listener);

    listener = (_) async {
      if (controller.status == AnimationStatus.completed) {
        await Future.delayed(widget.repeatPauseDuration);

        if (mounted && widget.repeat && widget.isAnimating) {
          controller.reset();
          controller.forward();
        }
      }
    };

    controller.addStatusListener(listener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    if (widget.startDelay != null) {
      await Future.delayed(widget.startDelay);
      if (mounted) controller.forward();
    } else {
      controller.forward();
    }
  }

  void _stopAnimation() async {
    controller?.reset();
    controller?.stop();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder creates its own closure for some reason
    // and widget.shape is not available inside its builder method
    final shape = widget.shape;
    final glowColor = widget.glowColor;

    return AnimatedBuilder(
      animation: alphaAnimation,
      child: widget.child,
      builder: (context, widgetChild) {
        final decoration = BoxDecoration(
          shape: shape,
          // If the user picks a curve that goes below 0,
          // this opacity will have unexpected effects
          color: glowColor.withOpacity(alphaAnimation.value.clamp(0.0, 1.0)),
        );

        return Container(
          height: widget.endRadius * 2,
          width: widget.endRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: bigDiscAnimation,
                builder: (context, widget) {
                  // If the user picks a curve that goes below 0,
                  // this will throw without clampping
                  final size =
                      bigDiscAnimation.value.clamp(0.0, double.infinity);

                  return Container(
                    height: size,
                    width: size,
                    decoration: decoration,
                  );
                },
              ),
              widget.showTwoGlows
                  ? AnimatedBuilder(
                      animation: smallDiscAnimation,
                      builder: (context, widget) {
                        final size = smallDiscAnimation.value
                            .clamp(0.0, double.infinity);

                        return Container(
                          height: size,
                          width: size,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widgetChild,
            ],
          ),
        );
      },
    );
  }
}
