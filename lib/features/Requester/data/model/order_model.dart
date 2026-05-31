class OrderModel {
  final String? id;
  final String? needyId;
  final String requestType;
  final int age;
  final String workStatus;
  final bool isFamily;
  final int familyMembers;
  final String city;
  final String village;
  final bool hasDisability;
  final String title;
  final String description;
  final String? prescriptionImage;
  final String? status;
  final String? requesterName;
  final String? priority;
  final int quantity;

  final String? requestSubmitted;
  final String? underReview;
  final String? matchingWithDonor;
  final String? onTheWay;
  final String? deliveryCompleted;
  final String? createdAt;

  const OrderModel({
    this.id,
    this.needyId,
    required this.requestType,
    required this.age,
    required this.workStatus,
    required this.isFamily,
    required this.familyMembers,
    required this.city,
    required this.village,
    required this.hasDisability,
    required this.title,
    required this.description,
    this.prescriptionImage,
    this.status,
    this.requesterName,
    this.priority,
    this.quantity = 1,
    this.requestSubmitted,
    this.underReview,
    this.matchingWithDonor,
    this.onTheWay,
    this.deliveryCompleted,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'needy_id': needyId,
      'request_type': requestType,
      'age': age,
      'work_status': workStatus,
      'is_family': isFamily,
      'family_members': familyMembers,
      'city': city,
      'village': village,
      'has_disability': hasDisability,
      'title': title,
      'description': description,
      'quantity': quantity,
      if (prescriptionImage != null && prescriptionImage!.isNotEmpty)
        'prescription_image': prescriptionImage,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final needy = map['needy_id'] is Map
        ? map['needy_id'] as Map<String, dynamic>
        : map['needy'] as Map<String, dynamic>?;

    return OrderModel(
      id: map['_id']?.toString() ?? map['id']?.toString(),
      needyId: needy?['_id']?.toString() ?? map['needy_id']?.toString(),
      requestType:
          map['request_type']?.toString() ?? map['category']?.toString() ?? '',
      age: (map['age'] as num?)?.toInt() ?? 0,
      workStatus:
          map['work_status']?.toString() ?? map['jobStatus']?.toString() ?? '',
      isFamily:
          map['is_family'] == true ||
          map['is_family'] == 'true' ||
          map['familyType'] == 'family',
      familyMembers:
          (map['family_members'] as num?)?.toInt() ??
          (map['familyMembersCount'] as num?)?.toInt() ??
          0,
      city: map['city']?.toString() ?? '',
      village: map['village']?.toString() ?? '',
      hasDisability:
          map['has_disability'] == true || map['hasDisability'] == true,
      title: map['title']?.toString() ?? map['orderName']?.toString() ?? '',
      description:
          map['description']?.toString() ??
          map['orderDescription']?.toString() ??
          '',
      prescriptionImage:
          map['prescription_image']?.toString() ??
          map['prescriptionImageUrl']?.toString(),
      status: map['status']?.toString(),
      requesterName:
          needy?['name']?.toString() ?? map['requesterName']?.toString(),
      priority: map['priority']?.toString(),
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,

      // Pipeline fields
      requestSubmitted: map['request_submitted']?.toString(),
      underReview: map['under_review']?.toString(),
      matchingWithDonor: map['matching_with_donor']?.toString(),
      onTheWay: map['on_the_way']?.toString(),
      deliveryCompleted: map['delivery_completed']?.toString(),
      createdAt: map['createdAt']?.toString() ?? map['created_at']?.toString(),
    );
  }

  String get resolvedImage {
    switch (requestType) {
      case 'دواء':
      case 'علاج':
        return 'assets/images/firstaid.png';
      case 'ملابس':
      case 'لبس':
        return 'assets/images/cl2.png';
      case 'طعام':
      default:
        return 'assets/images/food.png';
    }
  }

  String get priorityLabel => priority ?? 'عاجل';

  String get locationLabel =>
      village.isNotEmpty ? 'مصر، $village' : 'مصر، $city';

  String get computedStatus {
    if (deliveryCompleted == 'completed') return 'delivery_completed';
    if (onTheWay == 'in_progress') return 'on_the_way';
    if (matchingWithDonor == 'in_progress') return 'matching_with_donor';
    if (underReview == 'in_progress') return 'under_review';
    return 'request_submitted';
  }

  String get statusLabel {
    if (deliveryCompleted == 'completed') return 'تم التوصيل';
    if (onTheWay == 'in_progress' || onTheWay == 'completed') {
      return 'في الطريق';
    }
    if (matchingWithDonor == 'in_progress' ||
        matchingWithDonor == 'completed') {
      return 'جاري التنفيذ';
    }
    if (underReview == 'in_progress' || underReview == 'completed') {
      return 'قيد المراجعة';
    }
    return 'تم الإرسال';
  }
}
