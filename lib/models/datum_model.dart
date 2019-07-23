
import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String datumToJson(Categories data) => json.encode(data.toJson());

class Categories {
  List<Category> categories;

  Categories({
    this.categories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => new Categories(
    categories: new List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": new List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  int id;
  String name;
  List<Product> products;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    this.id,
    this.name,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
    id: json["id"],
    name: json["name"],
    products: new List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "products": new List<dynamic>.from(products.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class Product {
  int id;
  String name;
  int quantity;
  List<Image> images;
  DateTime createdAt;
  DateTime updatedAt;
  int categoryId;

  Product({
    this.id,
    this.name,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.images
  });

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    categoryId: json["category_id"],
    images: new List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "category_id": categoryId,
    "images": new List<dynamic>.from(images.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
class Image {
  int id;
  String url;

  Image({
    this.id,
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => new Image(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}

/*
class Datum{
  List<Category> categories;
  Datum({this.categories});

  factory Datum.fromJson(Map<String, dynamic> json){
    List<Category> myCats = new List<Category> .from(
        json['data'].map((x) => Category.fromJson(x))
    );

    return Datum(
      categories: myCats,
    );
  }
}


class Category{
  final int id;
  final String name;
  List<Product> products;

  Category({this.id, this.name, this.products});

  factory Category.fromJson(Map<String, dynamic> json){
    List<Product> myProducts = new List<Product>.from(
      json['products'].map((x) => Product.fromJson(x))
    );
    return Category(
      id: json['id'],
      name: json['name'],
      products: myProducts
    );
  }
}

class Product{
  final int id;
  final String name;
  final String quantity;
  final int categoryId;

  Product({this.name, this.id, this.categoryId, this.quantity});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      name: json['name'],
      id: json['id'],
      categoryId: json['category_id'],
      quantity: json['quantity']
    );
  }
}*/

