import 'package:flutter/material.dart';
//import 'locationdisplay.dart';
import 'ringpainter.dart';
import 'test.dart';


class RingsWidget extends StatefulWidget {
  @override
  _RingsWidgetState createState() => _RingsWidgetState();
}

class _RingsWidgetState extends State<RingsWidget>
    with SingleTickerProviderStateMixin {
      
      final double cSizeX=600;
      final double cSizeY=600;
      
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: cSizeX,
          height: cSizeY,
          child: Stack(
            children: [
              Positioned.fill(
                child:AnimatedBuilder(
              animation: _animation!,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: RingsPainter(
                    animationValue: _animation!.value,
                  ),
                );
              },
            ),),
            Positioned.fill(
              child:PositionDifference1(cSizeY:cSizeY, cSizeX: cSizeX,),
              
            ),

             ],
          ),
        ),
      ],
    );
  }
}


  