import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahtage_eh/features/Requester/data/model/requester_model.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/data/repo/reqester_api.dart';
import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
import 'package:mahtage_eh/token_storage.dart';

class RequesterCubit extends Cubit<RequesterState> {
  RequesterCubit() : super(RequesterInitial());

  final ReqesterApi _api = ReqesterApi();
  RequesterModel? currentUser;

  Future<void> signup(RequesterModel requester) async {
    emit(RequesterLoading());

    final result = await _api.postRequester(requester);

    result.fold((error) => emit(RequesterError(error)), (user) async {
      debugPrint('==== SIGNUP SUCCESS (no token yet) ====');
      debugPrint('Name   : ${user.name}');
      debugPrint('UserId : ${user.id}');

      final loginResult = await _api.login(
        phone: requester.phone,
        password: requester.password,
      );

      loginResult.fold(
        (error) {
          debugPrint('==== AUTO-LOGIN AFTER SIGNUP FAILED: $error ====');
          currentUser = user;
          emit(SignupSuccess(user));
        },
        (loggedInUser) async {
          currentUser = loggedInUser;
          if (loggedInUser.token != null) {
            await TokenStorage.saveToken(loggedInUser.token!);
          }

          debugPrint('==== AUTO-LOGIN AFTER SIGNUP SUCCESS ====');
          debugPrint('Name   : ${loggedInUser.name}');
          debugPrint('UserId : ${loggedInUser.id}');
          debugPrint('Token  : ${loggedInUser.token}');

          emit(SignupSuccess(loggedInUser));
        },
      );
    });
  }

  Future<void> login({required String phone, required String password}) async {
    emit(RequesterLoading());

    final result = await _api.login(phone: phone, password: password);

    result.fold((error) => emit(RequesterError(error)), (user) async {
      currentUser = user;
      if (user.token != null) await TokenStorage.saveToken(user.token!);

      debugPrint('==== LOGIN SUCCESS ====');
      debugPrint('Name   : ${user.name}');
      debugPrint('UserId : ${user.id}');
      debugPrint('Token  : ${user.token}');

      emit(LoginSuccess(user));
    });
  }

  Future<void> loadUserFromToken(String token) async {
    await TokenStorage.saveToken(token);

    currentUser = RequesterModel(
      name: '',
      password: '',
      phone: '',
      nationalIdText: '',
      token: token,
    );

    await getProfile();

    debugPrint('==== loadUserFromToken DONE ====');
    debugPrint('UserId : ${currentUser?.id}');
    debugPrint('Name   : ${currentUser?.name}');
  }

  Future<void> checkSavedToken() async {
    emit(RequesterLoading());

    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      currentUser = RequesterModel(
        name: '',
        password: '',
        phone: '',
        nationalIdText: '',
        nationalIdImage: '',
        token: token,
      );

      await getProfile();

      emit(LoginSuccess(currentUser!));
    } else {
      emit(RequesterInitial());
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    currentUser = null;
    emit(RequesterInitial());
  }

  Future<void> createRequest(OrderModel order) async {
    if (currentUser?.token == null) {
      emit(RequesterError('يجب تسجيل الدخول أولاً'));
      return;
    }

    debugPrint('==== CREATE REQUEST PAYLOAD ====');
    debugPrint(const JsonEncoder.withIndent('  ').convert(order.toJson()));
    debugPrint('Token  : ${currentUser!.token}');
    debugPrint('UserId : ${currentUser!.id}');
    debugPrint('================================');

    emit(RequesterLoading());

    final result = await _api.createRequest(
      order: order,
      token: currentUser!.token!,
    );

    result.fold(
      (error) {
        debugPrint('==== CREATE REQUEST ERROR ====');
        debugPrint(error);
        emit(RequesterError(error));
      },
      (created) {
        debugPrint('==== CREATE REQUEST SUCCESS ====');
        debugPrint('Order ID: ${created.id}');
        emit(CreateRequestSuccess(created));
      },
    );
  }

  Future<void> getRequests() async {
    if (currentUser?.token == null) {
      emit(RequesterError('يجب تسجيل الدخول أولاً'));
      return;
    }

    if (currentUser?.id == null) {
      await getProfile();
    }

    if (currentUser?.id == null) {
      emit(RequesterError('تعذر تحديد هوية المستخدم'));
      return;
    }

    emit(RequesterLoading());

    debugPrint('==== GET REQUESTS FOR NEEDY: ${currentUser!.id} ====');

    final result = await _api.getRequestsByNeedyId(
      needyId: currentUser!.id!,
      token: currentUser!.token!,
    );

    result.fold((error) => emit(RequesterError(error)), (orders) {
      debugPrint('==== GOT ${orders.length} REQUESTS ====');
      emit(GetRequestsSuccess(orders));
    });
  }

  Future<void> getProfile() async {
    if (currentUser?.token == null) return;

    final result = await _api.getRequester(token: currentUser!.token);

    result.fold((error) => debugPrint('==== GET PROFILE ERROR: $error ===='), (
      user,
    ) {
      currentUser = RequesterModel(
        id: user.id,
        name: user.name,
        password: '',
        phone: user.phone,
        nationalIdText: user.nationalIdText,
        token: currentUser!.token,
      );
      debugPrint('==== PROFILE LOADED ====');
      debugPrint('UserId : ${currentUser?.id}');
      debugPrint('Name   : ${currentUser?.name}');
    });
  }
}
