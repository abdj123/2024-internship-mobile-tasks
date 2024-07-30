import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
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
          reusableText("Add  Product", FontWeight.w500, 16),
          const SizedBox()
        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xffF3F3F3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 36,
                        ),
                        reusableText("upload image", FontWeight.w500, 14)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableText("name", FontWeight.w500, 14),
                reusabletextField(""),
                const SizedBox(
                  height: 20,
                ),
                reusableText("category", FontWeight.w500, 14),
                reusabletextField(""),
                const SizedBox(
                  height: 20,
                ),
                reusableText("price", FontWeight.w500, 14),
                reusabletextField("\$"),
                const SizedBox(
                  height: 20,
                ),
                reusableText("description", FontWeight.w500, 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(width: 1, color: const Color(0xffD9D9D9))),
                  child: const Center(
                    child: TextField(
                      minLines: 5,
                      maxLines: 15,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 4),
                        hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, top: 28),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: const Color(0xff3F51F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 34),
                      child: Center(
                          child: reusableText(
                              "ADD", FontWeight.w600, 14, Colors.white)),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 34),
                    child: Center(
                        child: reusableText(
                            "DELETE", FontWeight.w600, 14, Colors.red)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
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

Container reusabletextField(String hint, {TextInputType? type}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: Center(
      child: TextField(
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
