
import 'package:ecommerce_app/constants/images.dart';
import 'package:ecommerce_app/custom_painter/bg_wave_custom_painter.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          // alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            CustomPaint(
              // size: Size(
              //   size.width,
              //   (size.width * 1.7857142857142858).toDouble(),
              // ),
              painter: BgWaveCustomPainter(context),
            ),
            Positioned(
              top: 36,
              right: 22,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(Images.placeHolder),
                radius: size.width * 0.13,
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
