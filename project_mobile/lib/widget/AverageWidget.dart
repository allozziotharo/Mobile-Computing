//materiale standard
import 'package:flutter/material.dart';

class AverageWidget extends StatelessWidget {
  final double average;

  const AverageWidget({Key? key, required this.average});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 4),
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("CFU: 0"),
            Divider(),
            Text("MEDIA: " + average.toString()),
          ],
        ));
  }

  void calculator(int sum, int length) {}
}
