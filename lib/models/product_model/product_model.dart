import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.isFavourite,
      required this.name,
      required this.price,
      required this.description,
      this.quantity});

  String image;
  String id;
  bool isFavourite;
  String name;
  double price;
  String description;
  int? quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        //deserialization
        image: json["image"],
        id: json["id"],
        isFavourite: false,
        name: json["name"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        //serialization
        "id": id,
        "name": name,
        "image": image,
        "isFavourite": isFavourite,
        "description": description,
        "price": price,
        "quantity": quantity,
      };

  ProductModel copyWith({
    int? quantity,
  }) =>
      ProductModel(
        image: image,
        id: id,
        isFavourite: isFavourite,
        name: name,
        price: price,
        description: description,
        quantity: quantity ?? this.quantity,
      );
}
