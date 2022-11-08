library avatar_glow;

import 'dart:async';

import 'package:flutter/material.dart';

class AvatarGlow extends StatefulWidget {
  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool animate;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration? startDelay;

  const AvatarGlow({
    Key? key,
    required this.child,
    required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.animate = true,
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
  late final _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );
  late final _smallDiscAnimation = Tween(
    begin: (widget.endRadius * 2) / 6,
    end: (widget.endRadius * 2) * (3 / 4),
  ).animate(_curve);
  late final _bigDiscAnimation = Tween(
    begin: 0.0,
    end: widget.endRadius * 2,
  ).animate(_curve);
  late final _alphaAnimation = Tween(
    begin: 0.30,
    end: 0.0,
  ).animate(_controller);

  late Timer _repeatPauseTimer;

  late void Function(AnimationStatus status) _statusListener = (_) async {
    if (controller.status == AnimationStatus.completed) {
      _repeatPauseTimer = Timer(widget.repeatPauseDuration, () {
        if (mounted && widget.repeat && widget.animate) {
          controller.reset();
          controller.forward();
        }
      });
    }
  };

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(AvatarGlow oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _startAnimation() async {
    _controller.addStatusListener(_statusListener);
    if (widget.startDelay != null) {
      await Future.delayed(widget.startDelay!);
    }
    if (mounted) {
      _controller.reset();
      _controller.forward();
    }
  }

  Future<void> _stopAnimation() async {
    _controller.removeStatusListener(_statusListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alphaAnimation,
      child: widget.child,
      builder: (_, widgetChild) {
        final decoration = BoxDecoration(
          shape: widget.shape,
          // If the user picks a curve that goes below 0 or above 1
          // this opacity will have unexpected effects without clamping
          color: widget.glowColor.withOpacity(
            _alphaAnimation.value.clamp(0.0, 1.0),
          ),
        );
        return SizedBox(
          height: widget.endRadius * 2,
          width: widget.endRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (widget.animate)
                AnimatedBuilder(
                  animation: _bigDiscAnimation,
                  builder: (_, __) {
                    // If the user picks a curve that goes below 0,
                    // this will throw without clamping
                    final _size =
                        _bigDiscAnimation.value.clamp(0.0, double.infinity);

                    return Container(
                      height: _size,
                      width: _size,
                      decoration: decoration,
                    );
                  },
                )
              else
                const SizedBox(height: 0.0, width: 0.0),
              if (widget.animate && widget.showTwoGlows)
                AnimatedBuilder(
                  animation: _smallDiscAnimation,
                  builder: (_, __) {
                    final _size =
                        _smallDiscAnimation.value.clamp(0.0, double.infinity);

                    return Container(
                      height: _size,
                      width: _size,
                      decoration: decoration,
                    );
                  },
                )
              else
                const SizedBox(height: 0.0, width: 0.0),
              widgetChild!,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _repeatPauseTimer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
