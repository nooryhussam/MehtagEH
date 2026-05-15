class RecommendedRequest {
  final String id;
  final String requestType;
  final String priority;
  final String city;
  final String village;
  final String needyPhone;
  final double predictedScore;
  final String title;
  final String description;
  final int familyMembers;
  final bool isFamily;
  final bool hasDisability;
  final int age;
  final String workStatus;
  final String prescriptionImage;
  final String matchingWithDonor;
  final String onTheWay;
  final String deliveryCompleted;
  final bool donorContactedNeedy;
  final bool donorSentDonation;
  final bool needyConfirmedReceipt;

  const RecommendedRequest({
    required this.id,
    required this.requestType,
    required this.priority,
    required this.city,
    required this.village,
    required this.needyPhone,
    required this.predictedScore,
    required this.title,
    required this.description,
    required this.familyMembers,
    required this.isFamily,
    required this.hasDisability,
    required this.age,
    required this.workStatus,
    required this.prescriptionImage,
    this.matchingWithDonor = 'deactivate',
    this.onTheWay = 'deactivate',
    this.deliveryCompleted = 'deactivate',
    this.donorContactedNeedy = false,
    this.donorSentDonation = false,
    this.needyConfirmedReceipt = false,
  });

  factory RecommendedRequest.fromMap(Map<String, dynamic> map) {
    return RecommendedRequest(
      id: map['_id']?.toString() ?? '',
      requestType: map['request_type']?.toString() ?? '',
      priority: map['priority']?.toString() ?? '',
      city: map['city']?.toString() ?? '',
      village: map['village']?.toString() ?? '',
      needyPhone: map['needy_phone']?.toString() ?? '',
      predictedScore: (map['predicted_score'] as num?)?.toDouble() ?? 0.0,
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      familyMembers: _toInt(map['family_members']),
      isFamily: map['is_family'] as bool? ?? false,
      hasDisability: map['has_disability'] as bool? ?? false,
      age: _toInt(map['age']),
      workStatus: map['work_status']?.toString() ?? '',
      prescriptionImage: map['prescription_image']?.toString() ?? '',
      matchingWithDonor: map['matching_with_donor']?.toString() ?? 'deactivate',
      onTheWay: map['on_the_way']?.toString() ?? 'deactivate',
      deliveryCompleted: map['delivery_completed']?.toString() ?? 'deactivate',
      donorContactedNeedy: map['donor_contacted_needy'] as bool? ?? false,
      donorSentDonation: map['donor_sent_donation'] as bool? ?? false,
      needyConfirmedReceipt: map['needy_confirmed_receipt'] as bool? ?? false,
    );
  }

  String get fullLocation {
    if (village.isNotEmpty) return '$city، $village';
    return city;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
