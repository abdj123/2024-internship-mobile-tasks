import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/reusable_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    productBloc.add(LoadAllProductEvent());

    super.initState();
  }

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
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key('error_snackbar_home'),
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(LogOutEvent());
                          Navigator.pushNamed(context, "/login_page");
                        },
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.logout_rounded),
                            )),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          reusableText(
                              "Available Products", FontWeight.w600, 24),
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
                        child: state is LoadedAllProductState
                            ? ListView.builder(
                                key: const Key("products_list"),
                                itemCount: state.allProducts.length,
                                itemBuilder: (context, index) {
                                  final item = state.allProducts[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/detail_page',
                                          arguments: ProductEntity(
                                              id: item.id,
                                              description: item.description,
                                              imageUrl: item.imageUrl,
                                              name: item.name,
                                              price: item.price));
                                    },
                                    child: ReusableCard(
                                        description: item.description,
                                        image: item.imageUrl,
                                        title: item.name,
                                        price: item.price),
                                  );
                                },
                              )
                            : state is LoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Container(
                                    child: Center(
                                        child: reusableText("No Product Found",
                                            FontWeight.w700, 24)),
                                  ))
                  ]),
            ),
          );
        },
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
