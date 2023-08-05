import 'package:amazon_clone_flutter/common/widgets/loder.dart';
import 'package:amazon_clone_flutter/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_clone_flutter/features/auth/account/screen/widget/single_product.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<Product>? product = [];

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void fetchProduct() async {
    product = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void delete(Product products, int index) async {
    adminServices.delete(
        context: context,
        product: products,
        onSuccess: () {
          product!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loder()
        : Scaffold(
            body: GridView.builder(
                itemCount: product!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = product![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(image: productData.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              delete(productData, index);
                            },
                            icon: Icon(Icons.delete_forever_outlined),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.routeName)
                    .then((value) {
                  fetchProduct();
                });
              },
              tooltip: 'Add a product',
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
