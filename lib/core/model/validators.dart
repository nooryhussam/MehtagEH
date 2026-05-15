class Validators {
  // Validation for name (Three Arabic names)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم مطلوب';
    }
    final trimmed = value.trim();
    final regex = RegExp(
      r'^([\u0600-\u06FF]+)\s+([\u0600-\u06FF]+)\s+([\u0600-\u06FF]+)$',
    );
    if (!regex.hasMatch(trimmed)) {
      return 'من فضلك أدخل الاسم ثلاثي بالحروف العربية فقط';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final regx = RegExp(r'^01[0-9]{9}$');
    if (!regx.hasMatch(value)) {
      return 'رقم الهاتف غير صحيح، يجب أن يكون 11 رقم يبدأ بـ 01';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب ألا تقل عن 8 حروف';
    }
    return null;
  }

  static String? nationalId(String? value) {
    if (value == null || value.isEmpty) {
      return "الرقم القومي مطلوب";
    }
    if (value.length != 14 || int.tryParse(value) == null) {
      return "ادخل الرقم القومي الصحيح (14 رقم)";
    }
    return null;
  }

  static String? validateRequired(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? numeric(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    if (int.tryParse(value) == null) {
      return 'برجاء إدخال أرقام فقط';
    }
    return null;
  }

  static String? validateSelection(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}
