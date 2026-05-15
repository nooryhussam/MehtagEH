import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahtage_eh/core/networking/api_constants.dart';
import 'package:mahtage_eh/core/networking/dio_helper.dart';
import 'package:mahtage_eh/features/auth/auth_Repo.dart';
import 'package:mahtage_eh/token_storage.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepository authRepository) : super(AuthInitial());

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.login,
        data: {'phone': identifier, 'password': password},
      );

      final json = response.data as Map<String, dynamic>;
      final token = json['token'] as String? ?? '';

      if (token.isEmpty) {
        emit(AuthError('لم يتم استلام التوكن من الخادم'));
        return;
      }

      await TokenStorage.saveToken(token);

      // Response shape: { token, data: { user: { name, role, ... }, donor: {...} } }
      final data = json['data'] as Map<String, dynamic>?;
      final userObj = data?['user'] as Map<String, dynamic>?;

      final name = userObj?['name']?.toString() ?? '';
      final userName = name.isNotEmpty ? name : 'مستخدم';

      final roleStr =
          userObj?['role']?.toString().toLowerCase() ??
          json['role']?.toString().toLowerCase();

      final UserRole role;
      if (roleStr == 'admin') {
        role = UserRole.admin;
      } else if (roleStr == 'donor') {
        role = UserRole.donor;
      } else {
        role = UserRole.requester;
      }

      emit(AuthSuccess(token: token, role: role, userName: userName));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    emit(AuthLoggedOut());
  }

  String _parseError(Object e) {
    try {
      final response = (e as dynamic).response;
      if (response == null) return 'تعذر الاتصال بالسيرفر';
      final data = response.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return 'خطأ ${response.statusCode}';
    } catch (_) {}
    return e.toString();
  }
}
