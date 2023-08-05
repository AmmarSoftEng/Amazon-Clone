import 'package:amazon_clone_flutter/common/widgets/custom_button.dart';
import 'package:amazon_clone_flutter/features/product_details/services/product_details_service.dart';
import 'package:amazon_clone_flutter/features/search/widget/stars.dart';
import 'package:amazon_clone_flutter/provider/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/globalVariables.dart';
import '../../search/screen/search_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  static const String routeName = '/product-details';
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  void navigationToShearch(String qurey) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: qurey);
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  void initState() {
    super.initState();
    // double totalRating = 0;
    // for (var i = 0; i < widget.product.rating!.length; i++) {
    //   totalRating = totalRating + widget.product.rating![i].rating;
    //   if (widget.product.rating![i].uid ==
    //       Provider.of<UserProvider>(context, listen: false).user.id) {
    //     myRating = widget.product.rating![i].rating;
    //   }
    // }

    // if (totalRating != 0) {
    //   avgRating = totalRating / widget.product.rating!.length;
    // }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: 5),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                  builder: (context) => Image.network(
                    i,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                );
              }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 200),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomeButton(text: 'Buy Now', onTab: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomeButton(
                text: 'Add to Cart',
                onTab: addToCart,
                color: Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rate The Product",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    );
                  },
                  onRatingUpdate: (rating) {
                    productDetailsServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating);
                  }),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
