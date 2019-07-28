// To parse this JSON orders, do
//
//     final OrdersList = OrdersListFromJson(jsonString);

import 'dart:convert';

OrdersList ordersListFromJson(String str) =>
    OrdersList.fromJson(json.decode(str));

String ordersListToJson(OrdersList orders) => json.encode(orders.toJson());

class OrdersList {
  List<Order> orders;

  OrdersList({
    this.orders,
  });

  factory OrdersList.fromJson(Map<String, dynamic> json) => new OrdersList(
        orders:
            new List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": new List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  int id;
  int userId;
  OrderStatus status;
  List<OrderItem> orderItems;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    this.id,
    this.userId,
    this.status,
    this.orderItems,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => new Order(
        id: json["id"],
        userId: json["user_id"],
        status: OrderStatusValues.map[json["status"]],
        orderItems: new List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": OrderStatusValues.reverse[status],
        "order_items":
            new List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };


      Map<String, dynamic> toMap() => {
        "order_id" : id,
        'user_id' : userId,
        // "order_items":
        //     new List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_status": OrderStatusValues.reverse[status],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

      


}

class OrderItem {
  int id;
  int orderId;
  int productId;
  int qty;
  Product product;
  OrderItemStatus status;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.product,
    this.status,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => new OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        qty: json["qty"],
        product: Product.fromJson(json['product']),
        status: orderItemStatusValues.map[json["status"]],
        comment: json["comment"] == null ? null : json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "qty": qty,
        'product': product.toJson(),
        "status": orderItemStatusValues.reverse[status],
        "comment": comment == null ? null : comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

      Map<String, dynamic> toMap() =>{
        'order_item_id' : id,
        "order_id": orderId,
        "product_id": productId,
        "qty": qty,
        // 'product': product.toJson(),
        "order_item_status": orderItemStatusValues.reverse[status],
        "comment": comment == null ? null : comment,
        "order_item_created_at": createdAt.toIso8601String(),
        "order_item_updated_at": updatedAt.toIso8601String(),
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

  Product(
      {this.id,
      this.name,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.images});

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        images: json['images'] == null
            ? null
            : new List<Image>.from(
                json["images"].map((x) => Image.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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

enum OrderItemStatus { CANCELED, APPROVED, CHECKING_BY_STOCK }

final orderItemStatusValues = new EnumValues({
  "Approved": OrderItemStatus.APPROVED,
  "Canceled": OrderItemStatus.CANCELED,
  "Checking By Stock": OrderItemStatus.CHECKING_BY_STOCK
});

enum OrderStatus { OPEN, CLOSE }

final OrderStatusValues =
    new EnumValues({"close": OrderStatus.CLOSE, "open": OrderStatus.OPEN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
