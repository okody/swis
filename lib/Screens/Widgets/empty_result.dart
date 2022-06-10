import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

class EmptyResult extends StatelessWidget {
  const EmptyResult(
      {Key? key, required this.message, required this.unDrawIllustration})
      : super(key: key);

  final String message;
  final UnDrawIllustration unDrawIllustration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 120),
      width: 300,
      height: 300,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          UnDraw(
            color: kMainColor,
            illustration: unDrawIllustration,
            placeholder: const Text(
              "loading..",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ), //optional, default is the CircularProgressIndicator().
            errorWidget: const Icon(Icons.error_outline,
                color: kMainColor,
                size:
                    30), //optional, default is the Text('Could not load illustration!').
          ),
          Positioned(
            bottom: -20,
            child: Text(message,
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
