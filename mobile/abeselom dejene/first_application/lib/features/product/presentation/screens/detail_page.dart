import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';

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
    final args = ModalRoute.of(context)!.settings.arguments as ProductEntity;

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
                  child: Image.network(
                    args.imageUrl,
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
                      reusableText(args.name, FontWeight.w600, 24),
                      reusableText("\$${args.price}", FontWeight.w500, 16),
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 45),
                  child: Text(
                    args.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocConsumer<ProductBloc, ProductState>(
                      listener: (context, state) {
                        if (state is SuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                          Navigator.pop(context);
                          context
                              .read<ProductBloc>()
                              .add(LoadAllProductEvent());
                        } else if (state is ErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            final productBloc =
                                BlocProvider.of<ProductBloc>(context);

                            productBloc.add(DeleteProductEvent(args.id));
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 34),
                              child: Center(
                                  child: reusableText("DELETE", FontWeight.w600,
                                      14, Colors.red)),
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/update_product',
                            arguments: ProductEntity(
                                id: args.id,
                                description: args.description,
                                imageUrl: args.imageUrl,
                                name: args.name,
                                price: args.price));
                      },
                      child: DecoratedBox(
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
