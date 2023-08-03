import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vespa_app/core/constants.dart';
import 'package:vespa_app/widgets/vespa_widget.dart';

class VespaScreen extends StatefulWidget {
  @override
  _VespaScreenState createState() => _VespaScreenState();
}

class _VespaScreenState extends State<VespaScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get maxHeight => MediaQuery.of(context).size.height;

  void _onDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _onDragEnd(DragEndDetails _details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        _details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0.0) {
      _animationController.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget _child) {
        return Transform.scale(
          // effect jika ditekan tahan ke atas gambar bisa mengecil
          scale: lerpDouble(1.0, .8, _animationController.value),
          // posisi gambar di atas kanan
          alignment: Alignment.topRight,
          child: GestureDetector(
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                // efek lengkung pd ujung gambar
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    (defaultBorderRadius * 3) * _animationController.value,
                  ),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0, 20),
                    blurRadius: 12,
                    color: const Color(0xFF77FAFA).withOpacity(.64),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  VespaWidget(
                    vespaDragPercent: _animationController.value,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
