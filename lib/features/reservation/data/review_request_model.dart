class ReviewRequestModel {
  int businessId;
  int userId;
  int stars;
  String review;

  ReviewRequestModel({
    required this.businessId,
    required this.userId,
    required this.stars,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {
      'business_id': businessId,
      'user_id': userId,
      'stars': stars,
      'review': review,
    };
  }
}