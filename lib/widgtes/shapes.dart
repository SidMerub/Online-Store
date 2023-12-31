import 'package:flutter/material.dart';
class WaveShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.0, size.height * 0.6);

    var firstEndpoint = Offset(size.width * 0.5, size.height * 0.6);
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.4);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width, size.height * 0.8);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.8);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
class ReverseWaveShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.0, size.height * 0.8);

    var firstEndpoint = Offset(size.width * 0.5, size.height * 0.8);
    var firstControlPoint = Offset(size.width * 0.25, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    var secondEndpoint = Offset(size.width, size.height * 0.6);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.6);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Starting point
    path.moveTo(0.0, size.height);

    // First endpoint and control point
    var firstEndpoint = Offset(size.width * 0.5, size.height);
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.8);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndpoint.dx, firstEndpoint.dy);

    // Second endpoint and control point
    var secondEndpoint = Offset(size.width, size.height);
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.8);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndpoint.dx, secondEndpoint.dy);

    // Closing the path
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
class ClipContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(ClipContainer oldClipper) => false;
}
