// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mahtage_eh/features/Requester/data/model/requester_model.dart';
// import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
// import 'package:mahtage_eh/features/Requester/data/repo/reqester_api.dart';
// import 'package:mahtage_eh/features/Requester/representation/cubit/requester_state.dart';
// import 'package:mahtage_eh/token_storage.dart';

// class RequesterCubit extends Cubit<RequesterState> {
//   RequesterCubit() : super(RequesterInitial());

//   final ReqesterApi _api = ReqesterApi();
//   RequesterModel? currentUser;

//   // ── Signup ────────────────────────────────────────────────────────────────
//   Future<void> signup(RequesterModel requester) async {
//     emit(RequesterLoading());

//     final result = await _api.postRequester(requester);

//     result.fold((error) => emit(RequesterError(error)), (user) async {
//       currentUser = user;
//       if (user.token != null) await TokenStorage.saveToken(user.token!);

//       debugPrint('==== SIGNUP SUCCESS ====');
//       debugPrint('Name   : ${user.name}');
//       debugPrint('UserId : ${user.id}');
//       debugPrint('Token  : ${user.token}');

//       emit(SignupSuccess(user));
//     });
//   }

//   // ── Login (called directly, not via AuthCubit) ────────────────────────────
//   Future<void> login({required String phone, required String password}) async {
//     emit(RequesterLoading());

//     final result = await _api.login(phone: phone, password: password);

//     result.fold((error) => emit(RequesterError(error)), (user) async {
//       currentUser = user;
//       if (user.token != null) await TokenStorage.saveToken(user.token!);

//       debugPrint('==== LOGIN SUCCESS ====');
//       debugPrint('Name   : ${user.name}');
//       debugPrint('UserId : ${user.id}');
//       debugPrint('Token  : ${user.token}');

//       emit(LoginSuccess(user));
//     });
//   }

//   // ── Called from login.dart after AuthCubit succeeds ───────────────────────
//   // AuthCubit gives us the token; we save it then fetch the full profile
//   // (including the _id) from the server so currentUser.id is never null.
//   Future<void> loadUserFromToken(String token) async {
//     await TokenStorage.saveToken(token);

//     // Seed currentUser with just the token so getProfile() can use it
//     currentUser = RequesterModel(
//       name: '',
//       password: '',
//       phone: '',
//       nationalIdText: '',
//       token: token,
//     );

//     // getProfile() hits GET /api/needies/me (or equivalent) and overwrites
//     // currentUser with the full object including id
//     await getProfile();

//     debugPrint('==== loadUserFromToken DONE ====');
//     debugPrint('UserId : ${currentUser?.id}');
//     debugPrint('Name   : ${currentUser?.name}');
//   }

//   // ── Auto-login on app start ───────────────────────────────────────────────
//   Future<void> checkSavedToken() async {
//     emit(RequesterLoading());

//     final token = await TokenStorage.getToken();

//     if (token != null && token.isNotEmpty) {
//       currentUser = RequesterModel(
//         name: '',
//         password: '',
//         phone: '',
//         nationalIdText: '',
//         nationalIdImage: '',
//         token: token,
//       );

//       await getProfile();

//       emit(LoginSuccess(currentUser!));
//     } else {
//       emit(RequesterInitial());
//     }
//   }

//   // ── Logout ────────────────────────────────────────────────────────────────
//   Future<void> logout() async {
//     await TokenStorage.deleteToken();
//     currentUser = null;
//     emit(RequesterInitial());
//   }

//   // ── Create request ────────────────────────────────────────────────────────
//   Future<void> createRequest(OrderModel order) async {
//     if (currentUser?.token == null) {
//       emit(RequesterError('يجب تسجيل الدخول أولاً'));
//       return;
//     }

//     debugPrint('==== CREATE REQUEST PAYLOAD ====');
//     debugPrint(const JsonEncoder.withIndent('  ').convert(order.toJson()));
//     debugPrint('Token  : ${currentUser!.token}');
//     debugPrint('UserId : ${currentUser!.id}');
//     debugPrint('================================');

//     emit(RequesterLoading());

//     final result = await _api.createRequest(
//       order: order,
//       token: currentUser!.token!,
//     );

//     result.fold(
//       (error) {
//         debugPrint('==== CREATE REQUEST ERROR ====');
//         debugPrint(error);
//         emit(RequesterError(error));
//       },
//       (created) {
//         debugPrint('==== CREATE REQUEST SUCCESS ====');
//         debugPrint('Order ID: ${created.id}');
//         emit(CreateRequestSuccess(created));
//       },
//     );
//   }

//   // ── Get requests ──────────────────────────────────────────────────────────
//   Future<void> getRequests() async {
//     if (currentUser?.token == null) {
//       emit(RequesterError('يجب تسجيل الدخول أولاً'));
//       return;
//     }
//     emit(RequesterLoading());
//     final result = await _api.getRequests(token: currentUser!.token!);
//     result.fold(
//       (error) => emit(RequesterError(error)),
//       (orders) => emit(GetRequestsSuccess(orders)),
//     );
//   }

//   // ── Get profile from server ───────────────────────────────────────────────
//   Future<void> getProfile() async {
//     if (currentUser?.token == null) return;

//     final result = await _api.getRequester(token: currentUser!.token);

//     result.fold((error) => debugPrint('==== GET PROFILE ERROR: $error ===='), (
//       user,
//     ) {
//       currentUser = RequesterModel(
//         id: user.id,
//         name: user.name,
//         password: '',
//         phone: user.phone,
//         nationalIdText: user.nationalIdText,
//         token: currentUser!.token,
//       );
//       debugPrint('==== PROFILE LOADED ====');
//       debugPrint('UserId : ${currentUser?.id}');
//       debugPrint('Name   : ${currentUser?.name}');
//     });
//   }
// }

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

  // ── Signup ────────────────────────────────────────────────────────────────
  Future<void> signup(RequesterModel requester) async {
    emit(RequesterLoading());

    final result = await _api.postRequester(requester);

    result.fold((error) => emit(RequesterError(error)), (user) async {
      debugPrint('==== SIGNUP SUCCESS (no token yet) ====');
      debugPrint('Name   : ${user.name}');
      debugPrint('UserId : ${user.id}');

      // الـ signup response مش بترجع token — بنعمل login تلقائياً
      // عشان نجيب الـ token والـ profile كامل بالاسم
      final loginResult = await _api.login(
        phone: requester.phone,
        password: requester.password,
      );

      loginResult.fold(
        (error) {
          // الـ signup نجح بس الـ auto-login فشل — نوريله SignupSuccess بدون token
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

  // ── Login (called directly, not via AuthCubit) ────────────────────────────
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

  // ── Called from login.dart after AuthCubit succeeds ───────────────────────
  // AuthCubit gives us the token; we save it then fetch the full profile
  // (including the _id) from the server so currentUser.id is never null.
  Future<void> loadUserFromToken(String token) async {
    await TokenStorage.saveToken(token);

    // Seed currentUser with just the token so getProfile() can use it
    currentUser = RequesterModel(
      name: '',
      password: '',
      phone: '',
      nationalIdText: '',
      token: token,
    );

    // getProfile() hits GET /api/needies/me (or equivalent) and overwrites
    // currentUser with the full object including id
    await getProfile();

    debugPrint('==== loadUserFromToken DONE ====');
    debugPrint('UserId : ${currentUser?.id}');
    debugPrint('Name   : ${currentUser?.name}');
  }

  // ── Auto-login on app start ───────────────────────────────────────────────
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

  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await TokenStorage.deleteToken();
    currentUser = null;
    emit(RequesterInitial());
  }

  // ── Create request ────────────────────────────────────────────────────────
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

  // ── Get requests ──────────────────────────────────────────────────────────
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

  // ── Get profile from server ───────────────────────────────────────────────
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
