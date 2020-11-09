import 'package:siresto_app/data/model/customer_review.dart';

class MerchantResult {
  bool error;
  String message;
  int founded;
  int count;
  List<Merchant> dataList;
  Merchant data;

  MerchantResult({
    this.error = false,
    this.message,
    this.founded,
    this.count,
    this.dataList,
    this.data,
  });

  MerchantResult.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    founded = json['founded'];
    count = json['count'];
    if (json['restaurants'] != null) {
      dataList = List<Merchant>();
      json['restaurants'].forEach((merchant) {
        dataList.add(Merchant.fromJson(merchant));
      });
    }
    if (json['restaurant'] != null) {
      data = Merchant.fromJson(json['restaurant']);
    }
  }
}

class Merchant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  MerchantMenu menus;
  List<CustomerReview> customerReviews;

  Merchant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
    this.customerReviews,
  });

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    if (json['rating'] is double) {
      rating = json['rating'];
    } else {
      rating = double.parse(json['rating'].toString());
    }
    if (json["menus"] != null) {
      menus = MerchantMenu.fromJson(json['menus']);
    }
    if (json["customerReviews"] != null) {
      customerReviews = List<CustomerReview>();
      json["customerReviews"].reversed.forEach((review) {
        customerReviews.add(CustomerReview.fromJson(review));
      });
    }
  }
}

class MerchantMenuCategory {
  String name;
  String price;

  MerchantMenuCategory({this.name, this.price});

  MerchantMenuCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }
}

class MerchantMenu {
  List<MerchantMenuCategory> foods;
  List<MerchantMenuCategory> drinks;

  MerchantMenu({this.foods, this.drinks});

  MerchantMenu.fromJson(Map<String, dynamic> json) {
    foods = List<MerchantMenuCategory>();
    drinks = List<MerchantMenuCategory>();
    json['foods'].forEach((food) {
      foods.add(MerchantMenuCategory.fromJson(food));
    });
    json['drinks'].forEach((drink) {
      drinks.add(MerchantMenuCategory.fromJson(drink));
    });
  }
}
