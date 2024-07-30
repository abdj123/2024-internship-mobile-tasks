import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var list = List<int>.generate(10, (i) => i + 1 + 30);
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                  color: const Color(0xb3000000),
                  height: 280,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/Rectangle 27.png",
                    fit: BoxFit.cover,
                  )),
              Positioned(
                top: 10,
                left: 10,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    reusableText(
                        "Men’s shoe", FontWeight.w400, 16, Colors.grey),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    reusableText("(4.0)", FontWeight.w400, 16, Colors.grey),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableText("Derby Leather Shoes", FontWeight.w600, 24),
                      reusableText("\$120", FontWeight.w500, 16),
                    ],
                  ),
                ),
                reusableText("Size:", FontWeight.w500, 20),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: Card(
                          color: selected == index
                              ? const Color(0xff3F51F3)
                              : Colors.white,
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Center(
                                  child: reusableText(
                                      "${list[index]}",
                                      FontWeight.w500,
                                      20,
                                      selected == index
                                          ? Colors.white
                                          : Colors.black))),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 45),
                  child: Text(
                    "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 34),
                        child: Center(
                            child: reusableText(
                                "DELETE", FontWeight.w600, 14, Colors.red)),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color(0xff3F51F3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 34),
                        child: Center(
                            child: reusableText(
                                "UPDATE", FontWeight.w600, 14, Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
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
