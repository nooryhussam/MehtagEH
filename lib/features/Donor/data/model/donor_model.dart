class DonorModel {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String donorType;
  final String? token;

  const DonorModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.donorType,
    this.token,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'phone': phone,
    'email': email,
    'DONOR_type': donorType,
  };

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    final token = json['token'] as String?;
    final data = json['data'] as Map<String, dynamic>? ?? {};

    final idObj = data['_id'] as Map<String, dynamic>?;

    final userObj = data['user'] as Map<String, dynamic>?;
    final donorObj = data['donor'] as Map<String, dynamic>?;

    final user = userObj ?? idObj ?? {};
    final donor = donorObj ?? {};

    return DonorModel(
      id: user['_id']?.toString(),
      name: user['name']?.toString() ?? '',
      phone: user['phone']?.toString() ?? '',
      email: donor['email']?.toString() ?? data['email']?.toString() ?? '',
      password: '',
      donorType:
          donor['DONOR_type']?.toString() ??
          data['DONOR_type']?.toString() ??
          '',
      token: token,
    );
  }

  DonorModel copyWith({String? token}) => DonorModel(
    id: id,
    name: name,
    phone: phone,
    email: email,
    password: password,
    donorType: donorType,
    token: token ?? this.token,
  );
}
