class IdResponse {
  final String verification;

  IdResponse({required this.verification});

  factory IdResponse.fromJson(Map<String, dynamic> json) {
    return IdResponse(verification: json['verification'] ?? '');
  }

  bool get isVerified =>
      verification.toLowerCase().contains('verified successfully');
}
