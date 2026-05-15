import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahtage_eh/features/Donor/data/model/donation_model.dart';
import 'package:mahtage_eh/features/Donor/data/model/donor_model.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';
import 'package:mahtage_eh/features/Donor/data/repo/donor_api.dart';
import 'package:mahtage_eh/token_storage.dart';

import 'donor_state.dart';

class DonorCubit extends Cubit<DonorState> {
  DonorCubit() : super(DonorInitial());

  final DonorApi _api = DonorApi();
  DonorModel? currentDonor;

  List<RecommendedRequest> confirmedDonations = [];

  void confirmDonation(RecommendedRequest request) {
    if (!confirmedDonations.any((r) => r.id == request.id)) {
      confirmedDonations = [...confirmedDonations, request];
    }
    emit(ConfirmDonationSuccess(List.from(confirmedDonations)));
  }

  Future<void> signup(DonorModel donor) async {
    emit(DonorLoading());
    final result = await _api.postDonor(donor);
    result.fold((error) => emit(DonorError(error)), (createdDonor) async {
      currentDonor = createdDonor;
      if (createdDonor.token != null) {
        await TokenStorage.saveToken(createdDonor.token!);
        emit(DonorSignupSuccess(createdDonor));
      } else {
        final loginResult = await _api.login(
          phone: donor.phone,
          password: donor.password,
        );
        loginResult.fold((error) => emit(DonorError(error)), (
          loggedInDonor,
        ) async {
          currentDonor = loggedInDonor;
          if (loggedInDonor.token != null) {
            await TokenStorage.saveToken(loggedInDonor.token!);
          }
          emit(DonorSignupSuccess(loggedInDonor));
        });
      }
    });
  }

  Future<void> login({required String phone, required String password}) async {
    emit(DonorLoading());
    final result = await _api.login(phone: phone, password: password);
    result.fold((error) => emit(DonorError(error)), (donor) async {
      currentDonor = donor;
      if (donor.token != null) {
        await TokenStorage.saveToken(donor.token!);
      }
      emit(DonorLoginSuccess(donor));
    });
  }

  Future<void> checkSavedToken() async {
    emit(DonorLoading());
    final token = await TokenStorage.getToken();
    if (token != null && token.isNotEmpty) {
      currentDonor = DonorModel(
        name: '',
        email: '',
        password: '',
        phone: '',
        token: token,
        donorType: '',
      );
      emit(DonorLoginSuccess(currentDonor!));
    } else {
      emit(DonorInitial());
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    currentDonor = null;
    confirmedDonations = [];
    emit(DonorInitial());
  }

  Future<void> createDonation(DonationModel donation) async {
    if (currentDonor?.token == null) {
      emit(DonorError('يجب تسجيل الدخول أولاً'));
      return;
    }
    emit(DonorLoading());
    final result = await _api.postDonation(
      donation: donation,
      token: currentDonor!.token!,
    );
    result.fold(
      (error) {
        debugPrint(error);
        emit(DonorError(error));
      },
      (created) =>
          emit(CreateDonationSuccess(created, created.recommendedRequests)),
    );
  }

  Future<void> getApprovedRequests() async {
    if (currentDonor?.token == null) {
      emit(DonorError('يجب تسجيل الدخول أولاً'));
      return;
    }
    emit(DonorLoading());
    final result = await _api.getApprovedRequests(token: currentDonor!.token!);
    result.fold(
      (error) => emit(DonorError(error)),
      (requests) => emit(GetApprovedRequestsSuccess(requests)),
    );
  }

  Future<void> sendDonation(String requestId) async {
    if (currentDonor?.token == null) {
      emit(DonorError('يجب تسجيل الدخول أولاً'));
      return;
    }
    emit(DonorLoading());
    try {
      await _api.sendDonation(requestId, currentDonor!.token!);
      emit(SendDonationSuccess(requestId));
    } catch (e) {
      emit(DonorError(e.toString()));
    }
  }

  Future<void> getDonationStatus(String requestId) async {
    if (currentDonor?.token == null) {
      emit(DonorError('يجب تسجيل الدخول أولاً'));
      return;
    }
    emit(DonorLoading());
    final result = await _api.getDonationStatus(
      requestId: requestId,
      token: currentDonor!.token!,
    );
    result.fold(
      (error) => emit(DonorError(error)),
      (order) => emit(GetDonationStatusSuccess(order)),
    );
  }

  Future<void> getRequestById(String requestId) async {
    if (currentDonor?.token == null) {
      emit(DonorError('يجب تسجيل الدخول أولاً'));
      return;
    }
    emit(DonorLoading());
    final result = await _api.getRequestById(
      requestId: requestId,
      token: currentDonor!.token!,
    );
    result.fold(
      (error) => emit(DonorError(error)),
      (order) => emit(GetRequestByIdSuccess(order)),
    );
  }
}
