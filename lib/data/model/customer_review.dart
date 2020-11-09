class CustomerReviewResult {
  bool error;
  String message;
  List<CustomerReview> data;

  CustomerReviewResult({this.error = false, this.message, this.data});

  CustomerReviewResult.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    message = json["message"];
    if (json["customerReviews"] != null) {
      data = List<CustomerReview>();
      json["customerReviews"].forEach(
        (item) => data.add(CustomerReview.fromJson(item)),
      );
    }
  }
}

class CustomerReview {
  String name;
  String review;
  String date;
  String merchantId;

  CustomerReview({this.name, this.review, this.date, this.merchantId});

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = merchantId;
    data['name'] = name;
    data['review'] = review;
    return data;
  }
}
