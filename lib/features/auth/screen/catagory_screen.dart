import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/auth/home/service/home_service.dart';
import 'package:amazon_clone_flutter/features/product_details/screen/product_detial.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/globalVariables.dart';

class CatagoryDeals extends StatefulWidget {
  final String catagory;

  static const String routName = "/category_deals";

  const CatagoryDeals({
    Key? key,
    required this.catagory,
  }) : super(key: key);

  @override
  State<CatagoryDeals> createState() => _CatagoryDealsState();
}

class _CatagoryDealsState extends State<CatagoryDeals> {
  HomeService homeService = HomeService();
  List<Product>? product = [];
  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  void fetchCategoryProduct() async {
    product = await homeService.fetchCategoryProduct(
        context: context, category: widget.catagory);
    setState(() {});
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
            widget.catagory,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: product == null
          ? const Loder()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.catagory}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: GridView.builder(
                      itemCount: product!.length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //childAspectRatio: 1.4,
                      ),
                      itemBuilder: (context, index) {
                        var productData = product![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailScreen.routeName,
                                arguments: productData);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  )),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(productData.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  top: 5,
                                  left: 0,
                                  right: 0,
                                ),
                                child: Text(
                                  productData.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
