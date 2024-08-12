import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final dynamic price;
  const ReusableCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: "assets/Rectangle 27.png",
            image: image,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              reusableText(title, FontWeight.w500, 20),
              reusableText("\$$price", FontWeight.w500, 14),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                reusableText(description, FontWeight.w400, 12),
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
