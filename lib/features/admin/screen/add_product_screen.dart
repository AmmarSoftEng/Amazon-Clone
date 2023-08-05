import 'dart:io';

import 'package:amazon_clone_flutter/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter/common/widgets/custometextfiled.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/globalVariables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];

  final _addProductFormKek = GlobalKey<FormState>();

  @override
  void dispose() {
    priceController.dispose();
    discriptionController.dispose();
    productNameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKek.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        descriptions: discriptionController.text,
        quantity: double.parse(quantityController.text),
        catagory: category,
        price: double.parse(priceController.text),
        images: images,
      );
    }
  }

  void slectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              'Add Product',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKek,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1, height: 200))
                        : GestureDetector(
                            onTap: slectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10, 4],
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_copy_outlined,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Select product Images',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomeTextField(
                        controller: productNameController,
                        hintText: 'Product Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: discriptionController,
                        hintText: 'Discription'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: priceController, hintText: 'Product Price'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: quantityController, hintText: 'Quanity'),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: category,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            category = val!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeButton(text: 'Sell', onTab: sellProduct),
                  ],
                ),
              )),
        ));
  }
}
