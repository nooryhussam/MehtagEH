import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mahtage_eh/core/networking/api_constants.dart';
import 'package:mahtage_eh/core/networking/dio_helper.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/data/model/requester_model.dart';

class ReqesterApi {
  Future<Either<String, RequesterModel>> postRequester(
    RequesterModel requester,
  ) async {
    try {
      final response = await DioHelper.postFormData(
        endPoint: ApiConstants.requesterEndPoint,
        fields: requester.toJson(),
        filePath: requester.nationalIdImage,
        fileFieldName: 'national_id_image',
      );
      final created = RequesterModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return right(created);
    } catch (e) {
      return left(_parseError(e));
    }
  }

  // FIX: server returns ALL needies as a list.
  // We decode the JWT to get the userId, then find the matching record.
  Future<Either<String, RequesterModel>> getRequester({String? token}) async {
    try {
      final response = await DioHelper.getData(
        endPoint: ApiConstants.requesterEndPoint,
        token: token,
      );

      debugPrint('==== GET REQUESTER RESPONSE ====');
      debugPrint(response.data.toString());

      final raw = response.data;

      // Unwrap { success, count, data: [ ... ] }
      List<dynamic> list;
      if (raw is List) {
        list = raw;
      } else if (raw is Map) {
        final inner = raw['data'];
        if (inner is List) {
          list = inner;
        } else {
          // Single object (e.g. signup response)
          return right(RequesterModel.fromJson(raw as Map<String, dynamic>));
        }
      } else {
        return left('تعذر تحميل بيانات المستخدم');
      }

      // Extract userId from the JWT payload (no signature verification needed)
      String? userId;
      if (token != null) {
        userId = _extractUserIdFromToken(token);
        debugPrint('==== JWT userId: $userId ====');
      }

      // Each list item looks like:
      // { _id: { _id: "userId", name: "...", phone: "..." }, national_id_text, national_id_image }
      // The nested _id object IS the full user record.
      Map<String, dynamic>? match;

      if (userId != null) {
        for (final item in list) {
          final map = item as Map<String, dynamic>;
          final userObj = map['_id'];
          if (userObj is Map<String, dynamic>) {
            if (userObj['_id']?.toString() == userId) {
              match = map;
              break;
            }
          }
        }
      }

      if (match == null) {
        return left('لم يتم العثور على بيانات المستخدم');
      }

      // Flatten into a shape that RequesterModel.fromJson understands
      final userObj = match['_id'] as Map<String, dynamic>;
      final normalised = <String, dynamic>{
        '_id': userObj['_id']?.toString(),
        'name': userObj['name']?.toString() ?? '',
        'phone': userObj['phone']?.toString() ?? '',
        'national_id_text': match['national_id_text']?.toString() ?? '',
        'national_id_image': match['national_id_image']?.toString(),
      };

      debugPrint('==== NORMALISED PROFILE ====');
      debugPrint(normalised.toString());

      return right(RequesterModel.fromJson(normalised));
    } catch (e) {
      return left(_parseError(e));
    }
  }

  Future<Either<String, RequesterModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.login,
        data: {'phone': phone, 'password': password},
      );

      debugPrint('==== LOGIN RAW RESPONSE ====');
      debugPrint(response.data.toString());

      return right(
        RequesterModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      return left(_parseError(e));
    }
  }

  Future<Either<String, OrderModel>> createRequest({
    required OrderModel order,
    required String token,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.requests,
        data: order.toJson(),
        token: token,
      );

      // السيرفر بيرجع الطلب اللي اتكريت جوه حقل "data"
      // الـ _unwrap اللي عندك في الملف وظيفتها تشيل الغلاف ده
      final orderData = _unwrap(response.data);

      // تحويل البيانات لموديل عشان نقدر نبعته للـ Card
      return right(OrderModel.fromMap(orderData));
    } catch (e) {
      return left(_parseError(e));
    }
  }

  Future<Either<String, List<OrderModel>>> getRequests({
    required String token,
  }) async {
    try {
      final response = await DioHelper.getData(
        endPoint: ApiConstants.requests,
        token: token,
      );
      final list = _unwrapList(response.data);
      return right(
        list
            .map((item) => OrderModel.fromMap(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return left(_parseError(e));
    }
  }

  // Decodes the JWT payload (no signature check) and returns the userId.
  String? _extractUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }

      final decoded = utf8.decode(base64.decode(payload));
      final map = jsonDecode(decoded) as Map<String, dynamic>;
      return map['userId']?.toString();
    } catch (e) {
      debugPrint('JWT decode error: $e');
      return null;
    }
  }

  Map<String, dynamic> _unwrap(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      return raw['data'] as Map<String, dynamic>? ?? raw;
    }
    throw Exception('Unexpected response format: $raw');
  }

  List<dynamic> _unwrapList(dynamic raw) {
    if (raw is List) return raw;
    if (raw is Map) {
      final inner = raw['data'] ?? raw['requests'];
      if (inner is List) return inner;
    }
    throw Exception('Unexpected list response format: $raw');
  }

  String _parseError(Object e) {
    try {
      final response = (e as dynamic).response;
      if (response == null) {
        return 'تعذر الاتصال حالياً. يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';
      }
      final data = response.data;
      if (data is Map) {
        if (data['message'] != null) return data['message'].toString();
        if (data['error'] != null) return data['error'].toString();
        final errors = data['errors'];
        if (errors is List && errors.isNotEmpty) {
          return errors
              .map((e) => e is Map ? (e['msg'] ?? e.toString()) : e.toString())
              .join('\n');
        }
      }
      if (data is String && data.isNotEmpty) return data;
      return 'عذرًا، هناك مشكلة في السيرفر الآن. حاول مرة أخرى بعد قليل (${response.statusCode})';
    } catch (_) {}
    return e.toString();
  }

  Future<Either<String, List<OrderModel>>> getRequestsByNeedyId({
    required String needyId,
    required String token,
  }) async {
    try {
      final response = await DioHelper.getData(
        // This uses the endpoint you provided: api/requests/needy/{id}
        endPoint: ApiConstants.needyRequests(needyId),
        token: token,
      );

      // Using your existing _unwrapList to handle the { success, data: [] } structure
      final list = _unwrapList(response.data);

      return right(
        list
            .map((item) => OrderModel.fromMap(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return left(_parseError(e));
    }
  }
}
