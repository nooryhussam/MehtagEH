import 'package:mahtage_eh/features/Donor/data/model/donor_model.dart';
import 'package:mahtage_eh/features/Donor/data/model/donation_model.dart';
import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Donor/data/model/recommendation_model.dart';

abstract class DonorState {}

class DonorInitial extends DonorState {}

class DonorLoading extends DonorState {}

class DonorSignupSuccess extends DonorState {
  final DonorModel donor;
  DonorSignupSuccess(this.donor);
}

class DonorLoginSuccess extends DonorState {
  final DonorModel donor;
  DonorLoginSuccess(this.donor);
}

class CreateDonationSuccess extends DonorState {
  final DonationModel donation;
  final List<RecommendedRequest> recommendations;
  CreateDonationSuccess(this.donation, this.recommendations);
}

class ConfirmDonationSuccess extends DonorState {
  final List<RecommendedRequest> confirmedDonations;
  ConfirmDonationSuccess(this.confirmedDonations);
}

class GetApprovedRequestsSuccess extends DonorState {
  final List<OrderModel> requests;
  GetApprovedRequestsSuccess(this.requests);
}

class SendDonationSuccess extends DonorState {
  final String requestId;
  SendDonationSuccess(this.requestId);
}

class GetDonationStatusSuccess extends DonorState {
  final OrderModel order;
  GetDonationStatusSuccess(this.order);
}

class GetRequestByIdSuccess extends DonorState {
  final OrderModel order;
  GetRequestByIdSuccess(this.order);
}

class DonorError extends DonorState {
  final String message;
  DonorError(this.message);
}
