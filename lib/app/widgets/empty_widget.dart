import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(
            height: 10.0,
          ),
          Lottie.network(
              'https://assets9.lottiefiles.com/temp/lf20_Celp8h.json')
        ],
      ),
    );
  }
}
