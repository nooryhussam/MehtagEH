import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token ?? '';
    return await dio.get(endPoint, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer ${token ?? ''}';
    return await dio.post(endPoint, data: data);
  }

  static Future<Response> postFormData({
    required String endPoint,
    required Map<String, dynamic> fields,
    String? filePath,
    String fileFieldName = 'national_id_image',
    String? token,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer ${token ?? ''}';

    final formData = FormData.fromMap({
      ...fields,
      if (filePath != null)
        fileFieldName: await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
    });

    return await dio.post(endPoint, data: formData);
  }
}
