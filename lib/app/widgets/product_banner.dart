import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 4,
      width: screenSize.width,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 255, 123, 0), Colors.black],
              // stops: [0.6, 0.4],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'New Release',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Cool Shoes',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ],
          ),
          const Spacer(),
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/shoe2.png?alt=media&token=8c9f66f4-bbfb-42f2-80ce-1811e7d7fab7',
            width: 125,
          )
        ],
      ),
    );
  }
}
