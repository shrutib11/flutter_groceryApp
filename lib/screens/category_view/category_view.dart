import 'package:e_commerce/constants/routes.dart';
import 'package:e_commerce/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:e_commerce/models/category_model/category_model.dart';
import 'package:e_commerce/models/product_model/product_model.dart';
import 'package:e_commerce/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';

class CategoryViewState extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryViewState({super.key, required this.categoryModel});

  @override
  State<CategoryViewState> createState() => _CategoryViewStateState();
}

class _CategoryViewStateState extends State<CategoryViewState> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight * 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Text(
                            widget.categoryModel.name,
                            style: const TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    productModelList.isEmpty
                        ? const Center(
                            child: Text("Products are empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GridView.builder(
                                primary: false,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: productModelList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12),
                                itemBuilder: (ctx, index) {
                                  ProductModel singleProduct =
                                      productModelList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          singleProduct.image,
                                          height: 100,
                                          width: 100,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Price : \$${singleProduct.price}"),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ));
  }
}
