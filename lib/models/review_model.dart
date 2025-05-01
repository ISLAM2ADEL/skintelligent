import 'package:skintelligent/commons.dart';

class ReviewModel {
  final String pageIndex;
  final String pageSize;
  final int count;
  final List<ReviewItem> reviews;

  ReviewModel(
      {required this.pageIndex,
      required this.pageSize,
      required this.count,
      required this.reviews});
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      pageIndex: json[ApiKey.pageIndex],
      pageSize: json[ApiKey.pageSize],
      count: (json[ApiKey.count]),
      reviews: (json[ApiKey.data] as List)
          .map((e) => ReviewItem.fromJson(e))
          .toList(),
    );
  }
}

class ReviewItem {
  final int id;
  final String comment;
  final int rating;
  final String patientName;
  final String patientImage;
  final String createdAt;

  ReviewItem(
      {required this.id,
      required this.comment,
      required this.rating,
      required this.patientName,
      required this.patientImage,
      required this.createdAt});
  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      id: json[ApiKey.id],
      comment: json[ApiKey.comment],
      rating: (json[ApiKey.rating]),
      patientName: json[ApiKey.patientName],
      patientImage: json[ApiKey.patientImage],
      createdAt: json[ApiKey.createdAt],
    );
  }
}
