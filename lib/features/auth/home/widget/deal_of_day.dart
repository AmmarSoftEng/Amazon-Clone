import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/auth/home/service/home_service.dart';
import 'package:amazon_clone_flutter/features/product_details/screen/product_detial.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  HomeService homeService = HomeService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealofDay();
  }

  void fetchDealofDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loder()
        : product!.name.isEmpty
            ? SizedBox()
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      "Deal of the Day",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToDetailScreen();
                    },
                    child: Column(
                      children: [
                        Image.network(
                          product!.images[0],
                          height: 235,
                          fit: BoxFit.fitHeight,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '\$100',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                          child: Text(
                            'Deep Treatment Masque,Deep-penetrating hair masque. Precious shea butter and olive leaf extracts vitalise hair and moisturize',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://images.squarespace-cdn.com/content/v1/579a2cbfe6f2e1648e64c23a/1522351969675-R2QOK9JMNXYHF4RW03O5/Newsha+Product+Shots-Total+Control+Gel.png?format=1500w',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.network(
                          'https://images.squarespace-cdn.com/content/v1/579a2cbfe6f2e1648e64c23a/1522269441032-G48VVT74C8UJDW7GYJRI/Newsha+Product+Shots-High+Performance+Leave+In.png?format=1500w',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.network(
                          'https://images.squarespace-cdn.com/content/v1/579a2cbfe6f2e1648e64c23a/1636048192668-P0OI29RTT95FQT6M9GXA/c_aast_150ml_0_1.jpg?format=1000w',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.network(
                          'https://images.squarespace-cdn.com/content/v1/579a2cbfe6f2e1648e64c23a/1636048192663-L2AKZNYP0PSYI8IKB3TZ/c_aast_1000ml.jpg?format=1000w',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.network(
                          'https://images.squarespace-cdn.com/content/v1/579a2cbfe6f2e1648e64c23a/1522271808528-S2E5FRVPRIBW1X4HG42X/Newsha+Product+Shots-Natural+Hold+Hairspray.png?format=1500w',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ).copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}
