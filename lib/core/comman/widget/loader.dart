import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  // static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  // static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  // static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);


  final double size;
  final double strokeWidth;

  const Loading({super.key, required this.size, required this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return SweepGradient(
            colors: [AppPallet.gradient1, AppPallet.gradient2, AppPallet.gradient3, AppPallet.gradient1],
            stops: [0.0, 0.5, 0.9, 1.0], 
            startAngle: 0.0,
            endAngle: 3.14 * 2,
            tileMode: TileMode.clamp,
          ).createShader(bounds);
        },
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white), // will be masked
        ),
      ),
    );
  }
}
