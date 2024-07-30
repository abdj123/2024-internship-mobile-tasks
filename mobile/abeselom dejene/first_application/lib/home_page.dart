import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/create_product');
        },
        tooltip: 'Add',
        heroTag: 'contact',
        backgroundColor: const Color(0xff3F51F3),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(11)),
                child: const SizedBox(
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                reusableText("July 14, 2023", FontWeight.w400, 12),
                reusableText("Hello, Yohannes", FontWeight.w600, 15)
              ]),
              const Spacer(),
              DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(CupertinoIcons.bell),
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, bottom: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusableText("Available Products", FontWeight.w600, 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search_page');
                    },
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(CupertinoIcons.search),
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail_page');
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/Rectangle 27.png",
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              reusableText(
                                  "Derby Leather Shoes", FontWeight.w500, 20),
                              reusableText("\$120", FontWeight.w500, 14),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                reusableText("Men’s shoe", FontWeight.w400, 12),
                                const Spacer(),
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 15),
                                reusableText("(4.0)", FontWeight.w400, 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
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
