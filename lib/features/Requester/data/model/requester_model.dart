// class RequesterModel {
//   final String? id;
//   final String name;
//   final String password;
//   final String phone;
//   final String nationalIdText;
//   final String? nationalIdImage;
//   final String? token;

//   const RequesterModel({
//     this.id,
//     required this.name,
//     required this.password,
//     required this.phone,
//     required this.nationalIdText,
//     this.nationalIdImage,
//     this.token,
//   });

//   // ✅ تستخدم لإرسال البيانات للسيرفر عند التسجيل أو تسجيل الدخول
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'password': password,
//     'phone': phone,
//     'national_id_text': nationalIdText,
//     // إذا كنت ترفع صورة الهوية كمسار نصي أو Base64
//     if (nationalIdImage != null) 'national_id_image': nationalIdImage,
//   };

//   // ✅ تستخدم لتحويل الرد القادم من السيرفر إلى كائن (Object)
//   // تتعامل مع شكل الـ JSON المعقد (data.user & data.needy)
//   factory RequesterModel.fromJson(Map<String, dynamic> json) {
//     // 1. استخراج البيانات من داخل 'data' إن وجدت (شكل رد الـ Login)
//     final data = json['data'] as Map<String, dynamic>?;
//     final user = data?['user'] as Map<String, dynamic>?;
//     final needy = data?['needy'] as Map<String, dynamic>?;

//     // 2. التعامل مع الهيكل المسطح (شكل رد الـ Signup)
//     final flatNeedy = json['needy'] as Map<String, dynamic>?;

//     // 3. تحديد الـ ID (يبحث في كل الأماكن المحتملة)
//     final id =
//         user?['_id']?.toString() ??
//         needy?['_id']?.toString() ??
//         flatNeedy?['_id']?.toString() ??
//         json['_id']?.toString() ??
//         json['id']?.toString();

//     // 4. استخراج الاسم والphone
//     final name = user?['name']?.toString() ?? json['name']?.toString() ?? '';
//     final phone = user?['phone']?.toString() ?? json['phone']?.toString() ?? '';

//     // 5. استخراج بيانات الهوية الوطنية
//     final nationalIdText =
//         needy?['national_id_text']?.toString() ??
//         flatNeedy?['national_id_text']?.toString() ??
//         json['national_id_text']?.toString() ??
//         '';

//     final nationalIdImage =
//         needy?['national_id_image']?.toString() ??
//         flatNeedy?['national_id_image']?.toString() ??
//         json['national_id_image']?.toString();

//     // 6. استخراج التوكن
//     final token = json['token'] as String?;

//     return RequesterModel(
//       id: id,
//       name: name,
//       password: '', // الباسورد لا يعود من السيرفر لأسباب أمنية
//       phone: phone,
//       nationalIdText: nationalIdText,
//       nationalIdImage: nationalIdImage,
//       token: token,
//     );
//   }

//   // عمل نسخة معدلة من الكائن
//   RequesterModel copyWith({
//     String? id,
//     String? name,
//     String? phone,
//     String? nationalIdText,
//     String? nationalIdImage,
//     String? token,
//   }) => RequesterModel(
//     id: id ?? this.id,
//     name: name ?? this.name,
//     password: password,
//     phone: phone ?? this.phone,
//     nationalIdText: nationalIdText ?? this.nationalIdText,
//     nationalIdImage: nationalIdImage ?? this.nationalIdImage,
//     token: token ?? this.token,
//   );
// }

// class RequesterModel {
//   final String? id;
//   final String name;
//   final String password;
//   final String phone;
//   final String nationalIdText;
//   final String? nationalIdImage;
//   final String? token;

//   const RequesterModel({
//     this.id,
//     required this.name,
//     required this.password,
//     required this.phone,
//     required this.nationalIdText,
//     this.nationalIdImage,
//     this.token,
//   });

//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'password': password,
//     'phone': phone,
//     'national_id_text': nationalIdText,
//   };

//   // ✅ FIX: handles the actual server response shape:
//   // { success, message, token, data: { user: { _id, name, phone }, needy: { ... } } }
//   factory RequesterModel.fromJson(Map<String, dynamic> json) {
//     // Unwrap the 'data' envelope if present
//     final data = json['data'] as Map<String, dynamic>?;
//     final user = data?['user'] as Map<String, dynamic>?;
//     final needy = data?['needy'] as Map<String, dynamic>?;

//     // Fallback to flat structure (used by signup / getRequester responses)
//     final flatNeedy = json['needy'] as Map<String, dynamic>?;

//     // ID: prefer data.user._id → data.needy._id → flat needy._id → top-level id
//     final id =
//         user?['_id']?.toString() ??
//         needy?['_id']?.toString() ??
//         flatNeedy?['_id']?.toString() ??
//         json['_id']?.toString() ??
//         json['id']?.toString();

//     // Name: prefer data.user.name → top-level name
//     final name = user?['name']?.toString() ?? json['name']?.toString() ?? '';

//     // Phone: prefer data.user.phone → top-level phone
//     final phone = user?['phone']?.toString() ?? json['phone']?.toString() ?? '';

//     // National ID fields from needy object
//     final nationalIdText =
//         needy?['national_id_text']?.toString() ??
//         flatNeedy?['national_id_text']?.toString() ??
//         json['national_id_text']?.toString() ??
//         '';

//     final nationalIdImage =
//         needy?['national_id_image']?.toString() ??
//         flatNeedy?['national_id_image']?.toString() ??
//         json['national_id_image']?.toString();

//     // Token is always at the top level
//     final token = json['token'] as String?;

//     return RequesterModel(
//       id: id,
//       name: name,
//       password: '',
//       phone: phone,
//       nationalIdText: nationalIdText,
//       nationalIdImage: nationalIdImage,
//       token: token,
//     );
//   }

//   RequesterModel copyWith({String? token}) => RequesterModel(
//     id: id,
//     name: name,
//     password: password,
//     phone: phone,
//     nationalIdText: nationalIdText,
//     nationalIdImage: nationalIdImage,
//     token: token ?? this.token,
//   );
// }

class RequesterModel {
  final String? id;
  final String name;
  final String password;
  final String phone;
  final String nationalIdText;
  final String? nationalIdImage;
  final String? token;

  const RequesterModel({
    this.id,
    required this.name,
    required this.password,
    required this.phone,
    required this.nationalIdText,
    this.nationalIdImage,
    this.token,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'phone': phone,
    'national_id_text': nationalIdText,
  };

  // ✅ FIX: handles the actual server response shape:
  // { success, message, token, data: { user: { _id, name, phone }, needy: { ... } } }
  factory RequesterModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    // Signup shape: data._id is the full user object (not an ID string)
    // { data: { _id: { _id, name, phone, ... }, national_id_text, national_id_image } }
    final userObj = (data?['_id'] is Map)
        ? data!['_id'] as Map<String, dynamic>
        : null;

    // Login/profile shape: { data: { user: {...}, needy: {...} }, token }
    final userNode = data?['user'] as Map<String, dynamic>?;
    final needyNode = data?['needy'] as Map<String, dynamic>?;

    // Flat fallback for getRequester / other endpoints
    final flatNeedy = json['needy'] as Map<String, dynamic>?;

    // ── ID ──────────────────────────────────────────────────────────────────
    final id =
        userObj?['_id']?.toString() ??
        userNode?['_id']?.toString() ??
        needyNode?['_id']?.toString() ??
        flatNeedy?['_id']?.toString() ??
        json['_id']?.toString() ??
        json['id']?.toString();

    // ── Name ────────────────────────────────────────────────────────────────
    final name =
        userObj?['name']?.toString() ??
        userNode?['name']?.toString() ??
        json['name']?.toString() ??
        '';

    // ── Phone ───────────────────────────────────────────────────────────────
    final phone =
        userObj?['phone']?.toString() ??
        userNode?['phone']?.toString() ??
        json['phone']?.toString() ??
        '';

    // ── National ID ─────────────────────────────────────────────────────────
    // In signup response these sit directly on data (not inside a nested object)
    final nationalIdText =
        data?['national_id_text']?.toString() ??
        needyNode?['national_id_text']?.toString() ??
        flatNeedy?['national_id_text']?.toString() ??
        json['national_id_text']?.toString() ??
        '';

    final nationalIdImage =
        data?['national_id_image']?.toString() ??
        needyNode?['national_id_image']?.toString() ??
        flatNeedy?['national_id_image']?.toString() ??
        json['national_id_image']?.toString();

    // ── Token ───────────────────────────────────────────────────────────────
    // Present in login response; absent in signup (cubit calls getProfile after)
    final token = json['token']?.toString() ?? json['access_token']?.toString();

    return RequesterModel(
      id: id,
      name: name,
      password: '',
      phone: phone,
      nationalIdText: nationalIdText,
      nationalIdImage: nationalIdImage,
      token: token,
    );
  }

  RequesterModel copyWith({String? token}) => RequesterModel(
    id: id,
    name: name,
    password: password,
    phone: phone,
    nationalIdText: nationalIdText,
    nationalIdImage: nationalIdImage,
    token: token ?? this.token,
  );
}
