import 'package:flutter/material.dart';

class ClipNotchedCircle extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path1 = Path();
    Path path2 = Path();
    // path.fillType = .evenOdd;
    // path.arcToPoint(.new(0, size.height), radius: .circular(10), largeArc: true);
    // path.addArc(.fromCircle(center: .new(size.width / 2, size.height / 2), radius: size.width / 2), - 3 * pi / 4, - pi);
    path1.addOval(.fromCircle(center: .new(size.width / 2, size.height / 2), radius: size.width / 2));
    path2.addOval(.fromCircle(center: .new(0 - size.width / 6, size.height / 2), radius: size.width / 1.8));

    // path.addOval(.fromLTRB(0, 0, size.width, size.height));

    return Path.combine(.difference, path1, path2);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
