class Merchant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  MerchantMenu menus;

  Merchant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
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
    menus = MerchantMenu.fromJson(json['menus']);
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
