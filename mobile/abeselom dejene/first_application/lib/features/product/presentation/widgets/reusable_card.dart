import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            "assets/Rectangle 27.png",
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              reusableText("Derby Leather Shoes", FontWeight.w500, 20),
              reusableText("\$120", FontWeight.w500, 14),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                reusableText("Men’s shoe", FontWeight.w400, 12),
                const Spacer(),
                const Icon(Icons.star, color: Colors.yellow, size: 15),
                reusableText("(4.0)", FontWeight.w400, 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
