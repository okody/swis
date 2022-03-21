import 'package:flutter/material.dart';

class Battery_Level extends StatelessWidget {
  const Battery_Level(
      {Key? key, required this.percentage, required this.height})
      : super(key: key);

  final num percentage;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: height * 0.2272,
            height: height * 0.08522,
            margin: EdgeInsets.all(height * 0.02272),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.2840 * height)),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: height * 0.56,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.11363),
                    border: Border.all(
                        color: Colors.white, width: height * 0.05681)),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.0681,
                  ),
                  Container(
                    width: height * 0.4318,
                    height: height * percentage * 0.8636,
                    decoration: BoxDecoration(
                        color: getColor(),
                        borderRadius: BorderRadius.circular(height * 0.05681)),
                  ),
                  SizedBox(
                    height: height * 0.0681,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Color getColor() {
    if (percentage > 0.60)
      return Colors.greenAccent;
    else if (percentage > 0.30)
      return Colors.yellow;
    else
      return Colors.red;
  }
}
