import 'package:flutter/material.dart';

class AryanLogo extends StatelessWidget {
  final double width;
  final double height;
  final double? translateY;
  final double? opacity;

  const AryanLogo({
    super.key,
    this.width = 150,
    this.height = 150,
    this.translateY,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/images/aryan_app.png',
      package:'resources_package',
      width: 55,
      height: 55,
    );

    // if (translateY != null) {
    //   logo = Transform.translate(offset: Offset(0, translateY!), child: logo);
    // }
    // if (opacity != null) {
    //   logo = Opacity(opacity: opacity!, child: logo);
    // }

    return SizedBox(width: width, height: height, child: logo);
  }
}
