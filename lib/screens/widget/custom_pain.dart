import 'package:flutter/material.dart';
import 'package:shoes_shop/constants.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColor.colorYellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.4);
    path0.quadraticBezierTo(size.width * 0.3, size.height * 0.45,
        size.width * 0, size.height * 0.7);
    path0.quadraticBezierTo(size.width * 0, size.height * 0.7, 0,
        size.height * 1);
    path0.lineTo(size.width, size.height * 1);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ContainerCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = AppColor.colorYellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path0 = Path();
    path0.moveTo(size.width*0.3,0);
    path0.quadraticBezierTo(size.width*0.38,size.height*0.17,0,size.height*0.29);
    path0.quadraticBezierTo(size.width*0,size.height*0,size.width*0,0);

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
