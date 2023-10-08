// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:e_commerce/firebase_helper/firebase_firestore_helper/firestore_helper.dart';
import 'package:e_commerce/models/order_model/order_model.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return Center(
              child: Text("No order found"),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 1.3)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 1.3)),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            height: 135,
                            width: 135,
                            child: Image.network(orderModel.products[0].image),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 140,
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderModel.products[0].name,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    orderModel.products.length > 1
                                        ? SizedBox.fromSize()
                                        : Column(
                                            children: [
                                              Text(
                                                "Quantity : ${orderModel.products[0].quantity.toString()}",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                            ],
                                          ),
                                    Text(
                                      "Total Price : \$${orderModel.totalPrice.toString()}",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      children: orderModel.products.length > 1
                          ? [
                              const Text("Details"),
                              Divider(
                                color: Colors.red,
                              ),
                              ...orderModel.products.map((singleProduct) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 6.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            child: Image.network(
                                                singleProduct.image),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 140,
                                              child: Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      singleProduct.name,
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Quantity : ${singleProduct.quantity.toString()}",
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Price : \$${singleProduct.price.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            ]
                          : [],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
