class OrderModel {
  String? user;
  Checkout? checkout;
  String? shippingAddress;
  Payment? payment;
  String? trackingNumber;
  List<Foods>? foods;
  String? status;
  String? sId;
  String? createdAt;
  String? updatedAt;

  OrderModel({
    this.user,
    this.checkout,
    this.shippingAddress,
    this.payment,
    this.trackingNumber,
    this.foods,
    this.status,
    this.sId,
    this.createdAt,
    this.updatedAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    checkout = json['checkout'] != null
        ? Checkout.fromJson(json['checkout'])
        : null;
    shippingAddress = json['shipping_address'];
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    trackingNumber = json['trackingNumber'];
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    if (checkout != null) {
      data['checkout'] = checkout!.toJson();
    }
    data['shipping_address'] = shippingAddress;
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    data['trackingNumber'] = trackingNumber;
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Checkout {
  int? totalPrice;
  int? totalApplyDiscount;
  int? feeShip;
  String? sId;

  Checkout({this.totalPrice, this.totalApplyDiscount, this.feeShip, this.sId});

  Checkout.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalApplyDiscount = json['totalApplyDiscount'];
    feeShip = json['feeShip'];
    sId = json['_id']; // This line was missing in your code
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalApplyDiscount'] = totalApplyDiscount;
    data['feeShip'] = feeShip;
    data['_id'] = sId;
    return data;
  }
}


class Payment {
  String? method;

  Payment({this.method});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    return data;
  }
}


class Foods {
  String? food;
  int? quantity;
  String? sId;

  Foods({this.food, this.quantity, this.sId});

  Foods.fromJson(Map<String, dynamic> json) {
    food = json['food'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food'] = food;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}