import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();
  void setInit() {
    final args = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    nameController.text = args.name;
    descriptionController.text = args.description;
    priceController.text = '${args.price}';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    setInit();
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
                      child: Image.network(
                        args.imageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableText("name", FontWeight.w500, 14),
                reusabletextField("", nameController),
                const SizedBox(
                  height: 20,
                ),
                reusableText("category", FontWeight.w500, 14),
                reusabletextField("", catagoryController),
                const SizedBox(
                  height: 20,
                ),
                reusableText("price", FontWeight.w500, 14),
                reusabletextField("\$", priceController),
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
                  child: Center(
                    child: TextField(
                      controller: descriptionController,
                      minLines: 5,
                      maxLines: 15,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 4),
                        hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is SuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      Navigator.pop(context);
                      context.read<ProductBloc>().add(LoadAllProductEvent());
                    } else if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final productName = nameController.text != args.name
                                ? nameController.text
                                : args.name;

                            final productprice =
                                priceController.text != args.price
                                    ? priceController.text
                                    : args.price;

                            final productDescription =
                                descriptionController.text != args.description
                                    ? descriptionController.text
                                    : args.description;

                            if (productName == '' ||
                                productprice == '' ||
                                productDescription == '' ||
                                !validatePrice(productprice)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please Provide Required Fields')));
                            } else {
                              final updatedProduct = ProductEntity(
                                  id: args.id,
                                  name: productName,
                                  description: productDescription,
                                  price: productprice,
                                  imageUrl: args.imageUrl);

                              final productBloc =
                                  BlocProvider.of<ProductBloc>(context);

                              productBloc.add(
                                  UpdateProductEvent(updatedProduct, args.id));
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 18.0, top: 28),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: const Color(0xff3F51F3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 34),
                                child: Center(
                                    child: state is! LoadingState
                                        ? reusableText("ADD", FontWeight.w600,
                                            14, Colors.white)
                                        : const CircularProgressIndicator()),
                              ),
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
                      ],
                    );
                  },
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

Container reusabletextField(String hint, TextEditingController controller,
    {TextInputType? type}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(6),
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

bool validatePrice(String value) {
  final int? price = int.tryParse(value);

  if (price == null) {
    return false;
  } else {
    return true;
  }
}
