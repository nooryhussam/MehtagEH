import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:mahtage_eh/features/Requester/data/model/id_model.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/id_state.dart';

class IdCubit extends Cubit<IdState> {
  IdCubit() : super(IdInitial());

  final Dio _dio = Dio();

  Future<void> verifyIdData({
    required String imagePath,
    required String enteredNationalId,
  }) async {
    final trimmed = enteredNationalId.trim();

    emit(IdLoading());

    try {
      print("=== Sending to API ===");
      print("Image path: $imagePath");
      print("NID: $trimmed");
      print("File extension: ${imagePath.split('.').last}");

      // بنقرأ الصورة كـ bytes عشان نتأكد إننا بنبعت الصورة الأصلية بدون أي تعديل
      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();
      print(
        "Image size in KB: ${(imageBytes.length / 1024).toStringAsFixed(1)}",
      );

      final formData = FormData.fromMap({
        "image": MultipartFile.fromBytes(
          imageBytes,
          filename: imagePath.split('/').last,
          contentType: DioMediaType('image', 'jpeg'),
        ),
        "user_nid": trimmed,
      });

      final response = await _dio.post(
        "https://hayam-mostafa-egyptian-id-extractor.hf.space/extract-id", // ✅ "/extract-id" مش "/predict"
        data: formData,
      );

      if (response.statusCode == 200) {
        final result = IdResponse.fromJson(response.data);

        if (result.isVerified) {
          emit(IdSuccess(result));
        } else {
          emit(
            IdError(
              "رقم البطاقة في الصورة لا يطابق الرقم المدخل، يرجى إعادة التصوير",
            ),
          );
        }
      } else {
        emit(IdError("فشل في قراءة بيانات الصورة (${response.statusCode})"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        emit(IdError("خطأ من الخادم: ${e.response?.statusCode}"));
      } else {
        emit(IdError("حدث خطأ أثناء الاتصال بالخادم"));
      }
    } catch (e) {
      emit(IdError("حدث خطأ غير متوقع"));
    }
  }
}
