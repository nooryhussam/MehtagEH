import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';

class DonationModel {
  final String? id;
  final String? donorId;
  final String donationType;
  final String availability;
  final String location;
  final String village;
  final int quantity;
  final String? status;
  final List<RecommendedRequest> recommendedRequests;

  const DonationModel({
    this.id,
    this.donorId,
    required this.donationType,
    required this.availability,
    required this.location,
    required this.village,
    required this.quantity,
    this.status,
    this.recommendedRequests = const [],
  });

  Map<String, dynamic> toJson() => {
    'donation_type': donationType,
    'availability': availability,
    'quantity': quantity,
    'location': location,
    'village': village,
  };

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final rawList = json['recommended_requests'] as List<dynamic>? ?? [];

    return DonationModel(
      id: data['_id']?.toString(),
      donorId: data['donor_id']?.toString(),
      donationType: data['donation_type']?.toString() ?? '',
      availability: data['availability']?.toString() ?? '',
      location: data['location']?.toString() ?? '',
      village: data['village']?.toString() ?? '',
      quantity: _toInt(data['quantity']),
      status: data['status']?.toString(),
      recommendedRequests: rawList
          .map((e) => RecommendedRequest.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
