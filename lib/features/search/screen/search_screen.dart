import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/auth/home/widget/addres_box.dart';
import 'package:amazon_clone_flutter/features/product_details/screen/product_detial.dart';
import 'package:amazon_clone_flutter/features/search/services/serch_services.dart';
import 'package:amazon_clone_flutter/features/search/widget/search_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/globalVariables.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key? key,
    required this.searchQuary,
  }) : super(key: key);
  static const String routeName = 'search-screen';
  String searchQuary;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? product = [];

  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
  }

  void fetchSearchProducts() async {
    product = await searchServices.fetchSearchProduct(
        context: context, searchQurey: widget.searchQuary);
    setState(() {});
  }

  void navigationToShearch(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(17),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigationToShearch,
                      decoration: InputDecoration(
                        prefix: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: 'Search Amazon',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                        // prefixIcon: Icon(Icons.search,color: Colors.black,size: 22,),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
      body: product == null
          ? Loder()
          : Column(
              children: [
                AddressBox(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: product!.length,
                      itemBuilder: (context, index) {
                        var p = product![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailScreen.routeName,
                                  arguments: p);
                            },
                            child: SearchProduct(product: product![index]));
                      }),
                )
              ],
            ),
    );
  }
}
