import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/reusable_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
              )),
          reusableText("Search  Product", FontWeight.w500, 16),
          const SizedBox()
        ]),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.sizeOf(context).width * 0.68,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: const TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        hintText: "Leather ",
                        hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        isDense: true,
                        suffixIcon: Icon(
                          //
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 31, 29, 29),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18.0),
                                        child: reusableText(
                                            "Category", FontWeight.w400, 16),
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.sizeOf(context).width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.black,
                                            // hintText: "Leather ",
                                            hintStyle: TextStyle(
                                                color: Color(0xffC1C1C1)),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16,
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      reusableText(
                                          "Price", FontWeight.w400, 16),
                                      RangeSlider(
                                        activeColor: const Color(0xff3F51F3),
                                        values: _currentRangeValues,
                                        max: 100,
                                        divisions: 5,
                                        labels: RangeLabels(
                                          _currentRangeValues.start
                                              .round()
                                              .toString(),
                                          _currentRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            _currentRangeValues = values;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: const Color(0xff3F51F3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 34),
                                          child: Center(
                                              child: reusableText(
                                                  "APPLY",
                                                  FontWeight.w600,
                                                  14,
                                                  Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color(0xff3F51F3),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail_page');
                      },
                      child: const ReusableCard(
                        image:
                            "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777304/images/lmngzkii9zfo17ohxa6n.jpg",
                        description: "",
                        price: 1,
                        title: "kjhkj",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container reusabletextField(String hint, TextEditingController controller,
    {TextInputType? type}) {
  return Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: Center(
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsetsDirectional.only(start: 4),
          hintStyle: const TextStyle(color: Color(0xffC1C1C1)),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    ),
  );
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
