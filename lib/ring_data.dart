 import 'package:flutter/material.dart';
import 'rippleAnimation.dart';

class RingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rings'),
      ),
      body: Center(
        child: RingsWidget(),
      ),
    );
  }
}
  