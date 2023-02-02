import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadialExpansion extends StatelessWidget {
  RadialExpansion({
    super.key,
    required this.minRadius,
    required this.maxRadius,
    this.child,
  }) : clipTween = Tween<double>(
          begin: 2.0 * minRadius,
          end: 2.0 * (maxRadius / math.sqrt2),
        );

  final double minRadius;
  final double maxRadius;
  final Tween<double> clipTween;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
        final double t =
            (size.width / 2.0 - minRadius) / (maxRadius - minRadius);
        final double rectClipExtent = clipTween.transform(t);
    return  ClipOval(
          child: Center(
            child: SizedBox(
              width: rectClipExtent,
              height: rectClipExtent,
              child: ClipRect(
                child: child,
              ),
            ),
          ),
        );
      
    
  }
}
