import 'package:mahtage_eh/core/networking/api_constants.dart';
import 'package:mahtage_eh/core/networking/dio_helper.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.login,
        data: {'phone': phone, 'password': password},
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception("فشل تسجيل الدخول: ${e.toString()}");
    }
  }
}
