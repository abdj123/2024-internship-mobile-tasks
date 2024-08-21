import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();

  File? selectedImage;

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
                GestureDetector(
                  key: const Key('image_picker'),
                  onTap: () async {
                    final temp = await pickImage();

                    setState(() {
                      selectedImage = temp;
                    });
                  },
                  child: SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xffF3F3F3)),
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 36,
                                ),
                                reusableText(
                                    "upload image", FontWeight.w500, 14)
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableText("name", FontWeight.w500, 14),
                reusabletextField("", nameController,
                    key: const Key('name_field')),
                const SizedBox(
                  height: 20,
                ),
                reusableText("category", FontWeight.w500, 14),
                reusabletextField("", catagoryController,
                    key: const Key('category_field')),
                const SizedBox(
                  height: 20,
                ),
                reusableText("price", FontWeight.w500, 14),
                reusabletextField("\$", priceController,
                    key: const Key('price_field')),
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
                      key: const Key('description_field'),
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
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          key: const Key('error_snackbar'),
                          content: Text(state.message)));
                    }

                    if (state is SuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          key: const Key('success_snackbar'),
                          content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (selectedImage == null ||
                                nameController.text == '' ||
                                descriptionController.text == '' ||
                                !validatePrice(priceController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      key: Key('warning_snackbar'),
                                      content: Text(
                                          'Please Provide Required Fields')));
                            } else {
                              final newProduct = ProductEntity(
                                  id: "",
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  price: priceController.text,
                                  imageUrl: selectedImage!.path);

                              final productBloc =
                                  BlocProvider.of<ProductBloc>(context);

                              productBloc.add(CreateProductEvent(newProduct));

                              setState(() {
                                selectedImage = null;
                                nameController.clear();
                                priceController.clear();
                                descriptionController.clear();
                              });
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
    {TextInputType? type, Key? key}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: const Color(0xffD9D9D9))),
    child: Center(
      child: TextField(
        key: key,
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

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

bool validatePrice(String value) {
  final int? price = int.tryParse(value);

  if (price == null) {
    return false;
  } else {
    return true;
  }
}
