import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mahtage_eh/core/networking/api_constants.dart';
import 'package:mahtage_eh/core/networking/dio_helper.dart';
import 'package:mahtage_eh/features/Donor/data/model/donation_model.dart';
import 'package:mahtage_eh/features/Donor/data/model/donor_model.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';

class DonorApi {
  Future<void> sendDonation(String requestId, String token) async {
    final response = await DioHelper.postData(
      endPoint: ApiConstants.sendDonation(requestId),
      data: {},
      token: token,
    );
    return response.data;
  }

  Future<Either<String, DonationModel>> postDonation({
    required DonationModel donation,
    required String token,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.donations,
        data: donation.toJson(),
        token: token,
      );

      debugPrint('Full response: ${response.data}');
      debugPrint(
        'recommended_requests: ${response.data['recommended_requests']}',
      );

      final model = DonationModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      debugPrint(
        'parsed recommendations count: ${model.recommendedRequests.length}',
      );

      return right(model);
    } catch (e) {
      debugPrint('postDonation error: $e');
      return left(_parseError(e));
    }
  }

  Future<Either<String, DonorModel>> postDonor(DonorModel donor) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.donorEndPoint,
        data: donor.toJson(),
      );
      return right(DonorModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      return left(_parseError(e));
    }
  }

  Future<Either<String, DonorModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.login,
        data: {'phone': phone, 'password': password},
      );
      return right(DonorModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      return left(_parseError(e));
    }
  }

  Future<Either<String, List<OrderModel>>> getApprovedRequests({
    required String token,
  }) async {
    try {
      final response = await DioHelper.getData(
        endPoint: ApiConstants.approvedRequests,
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

  Future<Either<String, OrderModel>> getDonationStatus({
    required String requestId,
    required String token,
  }) async {
    try {
      final response = await DioHelper.getData(
        endPoint: '${ApiConstants.requests}/$requestId',
        token: token,
      );
      return right(OrderModel.fromMap(_unwrap(response.data)));
    } catch (e) {
      return left(_parseError(e));
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
    if (e is DioException) {
      switch (e.response?.statusCode) {
        case 404:
          return 'البيانات مش موجودة';
        case 400:
          final errors = e.response?.data?['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            return errors[0]['msg']?.toString() ?? 'هذا الحساب مسجل بالفعل';
          }
          return 'هذا الحساب مسجل بالفعل';
        case 401:
          return 'يرجى تسجيل الدخول مرة أخرى';
        case 403:
          return 'مش مسموحلك بالدخول';
        case 500:
          return 'مشكلة في السيرفر، حاول تاني';
        default:
          return 'حدث خطأ، حاول مرة أخرى';
      }
    }
    return 'حدث خطأ غير متوقع';
  }

  Future<Either<String, OrderModel>> getRequestById({
    required String requestId,
    required String token,
  }) async {
    try {
      final response = await DioHelper.getData(
        endPoint: '${ApiConstants.requests}/$requestId',
        token: 'Bearer $token',
      );
      final data = response.data['data'] ?? response.data;
      return Right(OrderModel.fromMap(data as Map<String, dynamic>));
    } on DioException catch (e) {
      final message =
          e.response?.data['message']?.toString() ?? e.message ?? 'حدث خطأ';
      return Left(message);
    }
  }
}
