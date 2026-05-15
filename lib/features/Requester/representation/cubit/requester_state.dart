import 'package:mahtage_eh/features/Requester/data/model/order_model.dart';
import 'package:mahtage_eh/features/Requester/data/model/requester_model.dart';

abstract class RequesterState {}

class RequesterInitial extends RequesterState {}

class RequesterLoading extends RequesterState {}

/// create account requester
class SignupSuccess extends RequesterState {
  final RequesterModel user;
  SignupSuccess(this.user);
}

class LoginSuccess extends RequesterState {
  final RequesterModel user;
  LoginSuccess(this.user);
}
/////////////// /// create order requester

class CreateRequestSuccess extends RequesterState {
  final OrderModel request;
  CreateRequestSuccess(this.request);
}

class GetRequestsSuccess extends RequesterState {
  final List<OrderModel> requests;
  GetRequestsSuccess(this.requests);
}

class RequesterError extends RequesterState {
  final String message;
  RequesterError(this.message);
}
